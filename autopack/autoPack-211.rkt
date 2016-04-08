#lang racket
(require sxml
         "../fileUtils/file-utils.rkt"
         "../sdk/module.rkt"
         "response.rkt"
         (prefix-in http: "../autopack/racket-http-211.rkt")
         (prefix-in config: "../sdk/sdk-configuration.rkt"))

(define unity (find-executable-path "unity.exe"))
(define 7z (find-executable-path "7z.exe"))
(define unity-prj "e:/develop/unitysdk-2/assets")

(define packageName "com.hutong.supersdk")
(define channel "supersdk")

(define (->apk channel (packageName "com.hutong.supersdk"))
  (let*  ([reg (regexp channel)]
          [filepath (string-append unity-prj "/Plugins/Android/AndroidManifest.xml" )]
          [isRight (regexp-match reg (file->string filepath))])
    (if isRight
        (let ([code (system*/exit-code
                     unity
                     unity-prj
                     "-executeMethod"
                     "AutoBuilder.PerformAndroidBuild"
                     "-quit" 
                     (format "-CustomArgs:packageName=~a;channel=~a" packageName channel))])
          (displayln code)
          (if (= code 0)
              (displayln "ok")
              (displayln "fail")))
        (error 'SDK_ID_NOT_FOUND "~a not found" channel))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; unpack apk
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define java-exe (find-executable-path "java.exe"))
(define apktool (find-executable-path "apktool.jar"))
(define apktool-path "e:/apktool/")
(define pack-path (string-append apktool-path "pack/"))
(define apk-dir "e:/develop/apk/2.0/debug/")
(define executor-path "smali/com/hutong")
(define config-path "f:/dropbox/programming/racket/sdk/configuration")
;; singnature files, apktool history, unity resource, icon
(define unused-files '("original" "apktool.yml" "assets/bin" "smali/org/fmod" "smali/com/unity3d" "res/drawable/ic_launcher.png" "res/drawable/app_icon.png" "unknown" "assets/ssdk_version.xml"))

(define (copy-apk channel)
  (let ([new (string-append pack-path channel ".apk")]
        [old (string-append apk-dir channel ".apk")])
    (if (file-exists? old)
        (copy-file old new #t)
        (error 'NOT-FIND "~a not found" old))))
(define (unpack-apk channel)
  (let ([new (string-append pack-path channel ".apk")]
        [old (string-append apk-dir channel ".apk")])
    ;(copy-file old new #t)
    (delete-directory/files (string-append pack-path channel) #:must-exist? #f)
    (system* java-exe "-jar" apktool "d" "-f" new "-o" (string-append pack-path channel "/resource/" channel))))

;; delete unused files
(define (clean-files channel)
  (let ([root-path (string-append pack-path channel "/resource/" channel)])
    (if (directory-exists? root-path)
        (for ([file unused-files])
          (let ([p (string-append root-path "/" file)])
            (if (file-exists? p) (delete-file p)
                (delete-directory/files p #:must-exist? #f))))
        (error 'PATH-NOT-EXIST "~a doesn't exist" root-path))))

;; create icon directory
(define (create-icon channel)
  (let ([dir (string-append pack-path channel "/resource/" channel "/icon")])
    (make-directory dir)))

;; modify-manifest
(define (modify-manifest channel)
  (let* ([filepath (string-append pack-path channel "/resource/" channel "/AndroidManifest.xml")]
         [xml (call-with-input-file filepath
                (lambda (in)
                  (ssax:xml->sxml in '((android . "http://schemas.android.com/apk/res/android")))))]
         [manifest (append '(*TOP*  (@ (*NAMESPACES* (android "http://schemas.android.com/apk/res/android")))
                                    (*PI* xml "version=\"1.0\" encoding=\"utf-8\" standalone=\"no\""))
                           (list (cons 'manifest
                                       (append ((sxpath '(manifest @)) xml)
                                               ((sxpath '(manifest uses-permission)) xml)
                                               ((sxpath '(manifest permission)) xml)
                                               ((sxpath '(manifest application)) xml)))))])
    (call-with-output-file filepath
      (lambda (out)
        (srl:sxml->xml manifest out))
      #:exists 'replace)))

;;; generate sdk config
(define (->config channel)
  (let ([path (string-append config-path "/" channel ".rkt")])
    (if (file-exists? path)
        (let ([config (config:read-config path)]
              [xml-path (string-append pack-path channel "/resource/" channel "/" channel ".xml")])
          (config:write-xml config xml-path))
        (error 'CONFIG_FILE_NOT_FOUND "~a not found!" path))))

;;; zip src: hutong
(define (rearrange channel)
  (let* ([root-path (string-append pack-path channel)]
         [jar-path (string-append root-path "/resource/" channel "/" executor-path)]
         [resource (string-append root-path "/resource")]
         [executor (string-append root-path "/executor")]
         [executor-zip (string-append root-path "/" channel "-executor.zip")]
         [resource-zip (string-append root-path "/" channel "-resource.zip")])
    (cond 
      ((file-exists? executor-zip)
       (delete-file executor-zip))
      ((file-exists? resource-zip)
       (delete-file resource-zip)))
    (if (directory-exists? executor)
        (delete-directory/files executor)
        (make-directory* executor))
    (lhk-copy-directory/files jar-path (string-append executor "/hutong"))
    (delete-directory/files jar-path)
    (system*/exit-code 7z "a" executor-zip (string-append executor "/*"))
    (system*/exit-code 7z "a" resource-zip (string-append resource "/*"))))

;;; (resource-create "AndBaiDu" '((force_update "true") (current_version "true") (log "test")))

(define (resource-create channel #:force_update (force-update "true") #:current_version (current-version "true") #:log (log "init submit") #:version (version "2.0"))
  (let* ([response (http:resource-query `(("sdk_id" ,channel)))]
         [inner-version version]
         [root-path (string-append pack-path channel)]
         [resource (string-append root-path "/resource")]
         [icon (string-append pack-path "icon/" channel "/icon")]
         [resource-zip (string-append root-path "/" channel "-resource.zip")])
    (replace-version channel inner-version)
    (when (file-exists? resource-zip)
      (delete-file resource-zip))
    (lhk-copy-directory/files icon (string-append resource "/" channel "/icon"))
    (system*/exit-code 7z "a" resource-zip (string-append resource "/*"))
    (transfer 'create 'resource channel `((force-update ,force-update) (current-version ,current-version) (log ,log) (inner-version ,inner-version)))))


(define (executor-create channel #:resource-version (resource-version "2.0") #:api-version (api-version "1.1") #:log (log "init submit") #:version (version "1.1.2.0"))
  (let* ([api (number->string (get-api-id (get-api-table (http:api-query `(("api_version" ,api-version))))))]
         [resource-table (get-resource-table (http:resource-query
                                              `(("sdk_id" ,channel)
                                                ("inner_version" ,resource-version))))]
         [resource-id (number->string (get-resource-id resource-table))]
         [response (http:executor-query `(("sdk_id" ,channel)))]
         [executor-version version])
    (transfer 'create 'executor channel `((api ,api) (resource ,resource-id) (log ,log) (executor-version ,executor-version)))))

(define (resource-update channel (fields null) #:version (version "2.0") #:update-file? (update-file? #f))
  (let ([id (number->string (get-resource-id (get-resource-table (http:resource-query `(("sdk_id" ,channel) ("inner_version" ,version))))))])
    (when update-file?
      (let* ([root-path (string-append pack-path channel)]
             [resource (string-append root-path "/resource")]
             [icon (string-append pack-path "icon/" channel "/icon")]
             [dest-icon (string-append resource "/" channel "/icon")]
             [resource-zip (string-append root-path "/" channel "-resource.zip")])
        (replace-version channel version)
        (when (file-exists? resource-zip)
          (delete-file resource-zip))
        (when (directory-exists? dest-icon)
          (delete-directory/files dest-icon))
        (lhk-copy-directory/files icon dest-icon)
        (system*/exit-code 7z "a" resource-zip (string-append resource "/*"))))
    (transfer 'update 'resource channel (list id fields update-file?))))

(define (executor-update channel (fields null) #:version (version "1.1.2.0") #:update-file? (update-file? #f))
  (let ([id (number->string (get-executor-id (get-executor-table (http:executor-query `(("sdk_id" ,channel) ("version_name" ,version))))))])
    (values id)
    (transfer 'update 'executor channel (list id fields update-file?))))

(define (transfer op service channel params)
  (let* ([path (string-append config-path "/" channel ".rkt")]
         [resource-zip (format "~a-resource.zip" channel)]
         [resource-path (string-append pack-path channel "/" resource-zip)]
         [executor-zip (format "~a-executor.zip" channel)]
         [executor-path (string-append pack-path channel "/" executor-zip)])
    (replace-ip channel)
    (if (file-exists? path)
        (let* ([config (config:read-config path)]
               [resource-name (configuration-name config)]
               [resource-version (configuration-version config)]
               ;[inner-version (configuration-inner-version config)]
               [sdk-id (configuration-id config)]
               [platform "Android"]
               [type "GAME"]
               [lang "Unity3D"])
          (match (list op service params)
            [(list 'create 'resource (list
                                      (list 'force-update force-update)
                                      (list 'current-version current-version)
                                      (list 'log update-log)
                                      (list 'inner-version inner-version)))
             (http:resource-create `(("resource_name" ,resource-name)
                                     ("version_name" ,resource-version)
                                     ("inner_version" ,inner-version)
                                     ("sdk_id" ,sdk-id)
                                     ("for_platform" ,platform)
                                     ("type" ,type)
                                     ("update_log", update-log)
                                     ("force_update" ,force-update)
                                     ("current_version" ,current-version))
                                   `(("file" ,resource-zip ,resource-path)))]
            [(list 'create 'executor (list
                                      (list 'api api-id)
                                      (list 'resource resource-id)
                                      (list 'log update-log)
                                      (list 'executor-version executor-version)))
             (http:executor-create `(("executor_name" ,sdk-id)
                                     ("version_name" ,executor-version)
                                     ("for_api" ,api-id)
                                     ("for_resource" ,resource-id)
                                     ("sdk_id" ,sdk-id)
                                     ("for_lang" ,lang)
                                     ("update_log" ,update-log))
                                   `(("file" ,executor-zip ,executor-path)))]
            [(list 'update 'resource (list id fields update-file?))
             (if update-file? (http:resource-update id fields `(("file" ,resource-zip ,resource-path)))
                 (http:resource-update id fields '()))]
            [(list 'update 'executor (list id fields update-file?))
             (if update-file? (http:executor-update id fields `(("file" ,executor-zip ,executor-path)))
                 (http:executor-update id fields '()))]))
        (error 'RESOURCE-ZIP-NOT-FOUND "~a not found" path))))

;; modify test ip address
(define (replace-ip channel (insert "ssdk.sail2world.com") (pattern "192.168.2.[0-9]+:8080"))
  (let* ([reg (regexp pattern)]
         [filepath (string-append pack-path channel "/resource/" channel "/AndroidManifest.xml")]
         [after (regexp-replace reg (file->string filepath) insert)])
    (call-with-output-file filepath
      (lambda (out)
        (display after out))
      #:exists 'replace)))

;; update resource configuration inner-version
(define (replace-version channel (version "2.0") (pattern "innerVersion=\"[0-9.]+\""))
  (let* ([insert (format "innerVersion=\"~a\"" version)]
         [reg (regexp pattern)]
         [filepath (string-append pack-path channel "/resource/" channel "/" channel ".xml")]
         [after (regexp-replace reg (file->string filepath) insert)])
    (call-with-output-file filepath
      (lambda (out)
        (display after out))
      #:exists 'replace)))


(define (autopack channel)
  ;(copy-apk channel)
  (unpack-apk channel)
  (clean-files channel)
  (create-icon channel)
  (replace-ip channel)
  (modify-manifest channel)
  (->config channel)
  (rearrange channel))