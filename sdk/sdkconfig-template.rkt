#lang racket
(require xml
         "../xml/xml-utils.rkt"
         "sdk-module.rkt")

(provide sdk-config)

;(define xml (eat-xml "And360.xml"))
;(define sdk-elem (document-element xml))

;; setup meta-data
(define (setup-meta lst)
  (map (lambda (item)
         `(Item ((label ,(meta-data-label item))
                 (description ,(meta-data-description item))
                 (client-key ,(meta-data-client-key item))
                 (server-key ,(meta-data-server-key item))
                 (isForClient ,(if (meta-data-remote? item) "true" "false")))))
       lst))

;; modify manifest
(define (setup-manifest lst)
  (match lst
    [(list (? symbol? name) attrib content)
     (append `(NodeData ((node ,(symbol->string name))))
             (map (lambda (attrib)
                    `(Attribute ((name ,(symbol->string (car attrib)))
                                 (value ,(cadr attrib)))))  attrib)
             (map setup-manifest content))]
    [(list 'Revalue (? list? attrib))
     (car (map (lambda (attrib)
                 `(Revalue ((name ,(symbol->string (car attrib)))
                            (value ,(cadr attrib))))) attrib))]
    ['() '("")]))

;; import resource files
(define (setup-resource lst)
  (if (null? lst)
      '("")
      (map (lambda (item)
             `(Item ((url ,(resource-data-url item))
                     (name ,(resource-data-name item))
                     (description ,(resource-data-description item)))))
           lst)))

(define (sdk-config info param manifest resource)
  (let ([name (property-sdk-name info)]
        [sdk-id (property-sdk-id info)]
        [channel-id (property-channel-id info)]
        [sdk-version (property-sdk-version info)]
        [inner-version (property-inner-version info)]
        [has-icon (property-icon info)]
        [has-splash (property-splash info)])
    `(SDKConfig ((xmlns "supersdk_autopacking")
                 (xmlns:xsi "http://www.w3.org/2001/XMLSchema")
                 (iconModify ,(if has-icon "true" "false"))
                 (sdkName ,name)
                 (sdkChannelID ,channel-id)
                 (sdkID, sdk-id)
                 (sdkVersion ,sdk-version)
                 (innerVersion ,inner-version))
                ;; because for/list generate a list of items, so cons symbol Parameta to the list
                ,(cons 'Parameters (setup-meta param))
                
                ,(cons 'Manifest (setup-manifest manifest))
                ,(cons 'Resource (setup-resource resource)))))

;; write to files
(define (write-config info param manifest resource)
  (let ([xml (string-append
              (property-sdk-id info) ".xml")]
        [ex (sdk-config info param manifest resource)])
    (when (file-exists? xml)
      (delete-file xml))
    (call-with-output-file xml
      (lambda (out)
        (display "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" out)
        (display-xml/content (xexpr->xml ex) out)))))

(define (test info param manifest resource)
  (let ([ex1 (sdk-config info param manifest resource)])
    (if (xexpr? ex1)
        (display-xml/content (xexpr->xml ex1))
        (error 'Not-Xexpr "wrong"))))
