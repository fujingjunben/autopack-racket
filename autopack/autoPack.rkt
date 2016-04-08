#lang racket
(require sxml
         "../fileUtils/file-utils.rkt"
         "../sdk/module.rkt"
         "response.rkt"
         (prefix-in http: "../autopack/racket-http-211.rkt")
         (prefix-in config: "../sdk/sdk-configuration.rkt"))

(define unity (find-executable-path "unity.exe"))
(define 7z (find-executable-path "7z.exe"))

(define packageName "com.hutong.supersdk")
(define channel "supersdk")

(define (->apk channel (packageName "com.hutong.supersdk"))
  (let ([code (system*/exit-code
               unity
               "e:/develop/unitysdk-2/assets"
               "-executeMethod"
               "AutoBuilder.PerformAndroidBuild"
               "-quit" 
               (format "-CustomArgs:packageName=~a;channel=~a" packageName channel))])
    (displayln code)
    (if (= code 0)
        (displayln "ok")
        (displayln "fail"))))
;(define (->apk channel (packageName "com.hutong.supersdk"))
;  (print-to-current-port (system*/exit-code
;                          unity
;                          "e:/develop/unitysdk-2/assets"
;                          "-executeMethod"
;                          "AutoBuilder.PerformAndroidBuild"
;                          "-quit" "-batchmode"
;                          (format "-CustomArgs:packageName=~a;channel=~a" packageName channel))))

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
(define unused-files '("original" "apktool.yml" "assets/bin" "smali/org/fmod" "smali/com/unity3d" "res/drawable/ic_launcher.png" "res/drawable/app_icon.png" "unknown"))

(define (unpack-apk channel)
  (let ([new (string-append pack-path channel ".apk")]
        [old (string-append apk-dir channel ".apk")])
    (if (file-exists? old)
        (begin
          (copy-file old new #t)
          (delete-directory/files (string-append pack-path channel) #:must-exist? #f)
          (system* java-exe "-jar" apktool "d" "-f" new "-o" (string-append pack-path channel "/resource/" channel)))
        (error 'NOT-FIND "~a not found" old))))

;; delete unused files
(define (clean-files channel)
  (let ([root-path (string-append pack-path channel "/resource/" channel)])
    (if (directory-exists? root-path)
        (for ([file unused-files])
          (let ([p (string-append root-path "/" file)])
            (if (file-exists? p) (delete-file p)
                  (delete-directory/files p #:must-exist? #f))))
        (error 'PATH-NOT-EXIST "~a doesn't exist" root-path))))


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
(define (compress channel)
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

(define (resource-create channel (params '((force_update "true") (current_version "true") (log "init submit"))))
  (transfer 'create 'resource channel params))

(define (resource-update channel (fields null) #:update-file? (update-file? #f))
  (let ([id (number->string (get-resource-id (get-resource-table (http:resource-query `(("sdk_id" ,channel))))))])
    (transfer 'update 'resource channel (list id fields update-file?))))

(define (executor-create channel #:log (log "init submit") #:inner_version (inner_version "2.0") #:api_version (api_version "1.1"))
  (let ([api (number->string (get-api-id (get-api-table (http:api-query `(("api_version" ,api_version))))))]
        [resource (number->string (get-resource-id
                                   (get-resource-table (http:resource-query
                                                        `(("sdk_id" ,channel)
                                                          ("inner_version" ,inner_version)))
                                             )))])
    (transfer 'create 'executor channel `((api ,api) (resource ,resource) (log ,log)))))

(define (executor-update channel (fields null) #:update-file? (update-file? #f))
  (let ([id (number->string (get-executor-id (get-executor-table (http:executor-query `(("sdk_id" ,channel))))))])
    (transfer 'update 'executor channel (list id fields update-file?))))

(define (transfer op service channel params)
  (let* ([path (string-append config-path "/" channel ".rkt")]
         [resource-zip (format "~a-resource.zip" channel)]
         [resource-path (string-append pack-path channel "/" resource-zip)]
         [executor-zip (format "~a-executor.zip" channel)]
         [executor-path (string-append pack-path channel "/" executor-zip)])
    (if (file-exists? path)
        (let* ([config (config:read-config path)]
               [resource-name (configuration-name config)]
               [version (configuration-version config)]
               [inner-version (configuration-inner-version config)]
               [sdk-id (configuration-id config)]
               [platform "Android"]
               [type "GAME"]
               [lang "Unity3D"])
          (match (list op service params)
            [(list 'create 'resource (list
                                      (list 'force_update force-update)
                                      (list 'current_version current-version)
                                      (list 'log update-log)))
             (http:resource-create `(("resource_name" ,resource-name)
                                     ("version_name" ,version)
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
                                      (list 'log update-log)))
             (http:executor-create `(("executor_name" ,sdk-id)
                                     ("version_name" ,(format "~a.~a"
                                                             (get-api-version (hash-ref (http:api-query `(("id" ,api-id))) 'api))
                                                             (get-resource-inner-version
                                                              (hash-ref (http:resource-query `(("id" ,resource-id))) 'resource))))
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
(define (replace-ip channel (insert "ssdk.sail2world.com") (pattern "192.168.2.150:8080"))
  (let* ([reg (regexp pattern)]
        [filepath (string-append pack-path channel "/resource/" channel "/AndroidManifest.xml")]
        [after (regexp-replace reg (file->string filepath) insert)])
    (call-with-output-file filepath
      (lambda (out)
        (display after out))
      #:exists 'replace)))

(define (autopack channel)
  (unpack-apk channel)
  (clean-files channel)
  (replace-ip channel)
  (modify-manifest channel)
  (->config channel)
  (compress channel))