#lang racket
(require xml
         "../xml/xml-utils.rkt"
         "../libs/binding.rkt"
         "module.rkt")

(provide read-config
         write-config
         write-xml)

(define (get-binding key bindings default)
  (first (get-binding* key bindings (list default))))

(define (get-binding* key bindings default)
  (with-handlers ([exn:fail? (lambda _ default)])
    (extract-binding/single key bindings)))

(define (read-config config-file-name)
  (sexpr->config (call-with-input-file config-file-name read)))

(define (sexpr->config c)
  (define name (get-binding 'name c "supersdk"))
  (define id (get-binding 'id c "sdk-id"))
  (define channel (get-binding 'channel c "sdk-channel"))
  (define version (get-binding 'version c "sdk-version"))
  (define inner-version (get-binding 'inner-version c "2.0"))
  (define icon (get-binding 'icon c #f))
  (define exit-dialog? (get-binding 'exit-dialog? c #f))
  (define unity-pack? (get-binding 'unity-pack c #t))
  (define package-suffix (get-binding 'package-suffix c ""))
  (define meta-data (car (get-binding* 'meta-data c '())))
  (define manifest (car (get-binding* 'manifest c '())))
  (define resource (car (get-binding* 'resource c '())))
  (define attention (car (get-binding* 'attention c '())))
  (make-configuration name id channel version inner-version icon exit-dialog?
                      unity-pack? package-suffix meta-data manifest resource attention))

(define (write-config new config-path)
  (define sexpr (config->sexpr new))
  (call-with-output-file config-path
    (lambda (out) (pretty-write sexpr out))
    #:exists 'replace))

(define (config->sexpr config)
  `((name ,(configuration-name config))
    (id ,(configuration-id config))
    (channel ,(configuration-channel config))
    (version ,(configuration-version config))
    (inner-version ,(configuration-inner-version config))
    (icon ,(configuration-icon config))
    (exit-dialog? ,(configuration-exit-dialog? config))
    (unity-pack ,(configuration-unity-pack? config))
    (package-suffix ,(configuration-package-suffix config))
    (meta-data ,(configuration-meta-data config))
    (manifest ,(configuration-manifest config))
    (resource ,(configuration-resource config))
    (attention ,(configuration-attention config))))

;; setup meta-data
(define (setup-meta lst)
  (map (lambda (item)
         (match item
           [(list label description client-key remote? server-key)
            `(Item ((label ,label)
                    (description ,description)
                    (clientKey ,client-key)
                    (isClientKeyRemote ,(if remote? "true" "false"))
                    (serverKey ,server-key)))]
           ['() '("")]))
       lst))

;; modify manifest
(define (setup-manifest lst)
  (map (lambda (item)
         (match item
           [(list (? symbol? name) attrib content)
            (append `(NodeData ((node ,(symbol->string name))))
                    (map (lambda (attrib)
                           `(Attribute ((name ,(symbol->string (car attrib)))
                                        (value ,(cadr attrib)))))  attrib)
                    (setup-manifest content))]
           
           [(list 'Revalue (? list? attrib))
            (car (map (lambda (attrib)
                        `(Revalue ((name ,(symbol->string (car attrib)))
                                   (value ,(cadr attrib))))) attrib))]
           [(list (? symbol? name) content)
            (append `(NodeData ((node ,(symbol->string name))))
                    (setup-manifest content))]
           ['() '("")]))
       lst))

;; import resource files
(define (setup-resource lst)
  (if (null? lst)
      '("")
      (map (lambda (item)
             (match item
               [(list url name description)
                `(Item ((url ,url)
                        (name ,name)
                        (description ,description)))]))
           lst)))


(define (setup-res lst)
  (if (null? lst)
      '("")
      (map (lambda (item)
             `(Item ,item))
           lst)))

(define (config->xml config)
  (let ([name (configuration-name config)]
        [id (configuration-id config)]
        [channel (configuration-channel config)]
        [version (configuration-version config)]
        [inner-version (configuration-inner-version config)]
        [has-icon (configuration-icon config)])
    `(SDKConfig ((xmlns "supersdk_autopacking")
                 (xmlns:xsi "http://www.w3.org/2001/XMLSchema")
                 (iconModify ,(if has-icon "true" "false"))
                 (sdkName ,name)
                 (sdkChannelID ,channel)
                 (sdkID, id)
                 (sdkVersion ,version)
                 (innerVersion ,inner-version))
                ;; because for/list generate a list of items, so cons symbol Parameta to the list
                ,(cons 'Parameters (setup-meta (configuration-meta-data config)))
                
                ,(cons 'Manifest (setup-manifest (configuration-manifest config)))
                ,(cons 'Resource (setup-res (configuration-resource config))))))

;; write to files
(define (write-xml new xml-file-path)
  (define xml (config->xml new))
  (call-with-output-file xml-file-path
    (lambda (out)
      (display "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" out)
      (display-xml/content (xexpr->xml xml) out))
    #:exists 'replace))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; test
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (test info)
  (let ([ex1 (config->xml info)])
    (if (xexpr? ex1)
        (display-xml/content (xexpr->xml ex1))
        (error 'Not-Xexpr "wrong"))))

;; find sdk config files and generate sexpr file
(define (->config dir)
  (for ([path (in-directory dir)]
        #:when (regexp-match? #rx"And([a-zA-Z0-9]*)-config.rkt$" path))
    (let ([name (format "And~a.rkt" (second (regexp-match #rx"And([a-zA-Z0-9]*)-config.rkt$" path)))])
      (load path)
      (write-config 'info name))))
