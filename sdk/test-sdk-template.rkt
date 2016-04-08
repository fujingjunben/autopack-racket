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
                 (clientKey ,(meta-data-client-key item))
                 (isClientKeyRemote ,(if (meta-data-remote? item) "true" "false"))
                 (serverKey ,(meta-data-server-key item)))))
       
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
           ['() ("")]))
       lst))

;; import resource files
(define (setup-resource lst)
  (if (null? lst)
      '("")
      (map (lambda (item)
             `(Item ((url ,(res-url item))
                     (name ,(res-description item))
                     (description ,(res-attention item)))))
           lst)))


(define (setup-res lst)
  (if (null? lst)
      '("")
      (map (lambda (item)
             `(Item ,item))
           lst)))
(define (sdk-config info)
  (let ([name (sdk-name info)]
        [sdk-id (sdk-id info)]
        [channel-id (sdk-channel info)]
        [sdk-version (sdk-version info)]
        [inner-version (sdk-inner-version info)]
        [has-icon (sdk-icon info)])
    `(SDKConfig ((xmlns "supersdk_autopacking")
                 (xmlns:xsi "http://www.w3.org/2001/XMLSchema")
                 (iconModify ,(if has-icon "true" "false"))
                 (sdkName ,name)
                 (sdkChannelID ,channel-id)
                 (sdkID, sdk-id)
                 (sdkVersion ,sdk-version)
                 (innerVersion ,inner-version))
                ;; because for/list generate a list of items, so cons symbol Parameta to the list
                ,(cons 'Parameters (setup-meta (sdk-param info)))
                
                ,(cons 'Manifest (setup-manifest (sdk-manifest info)))
                ,(cons 'Resource (setup-res (sdk-resource info))))))

;; write to files
(define (write-config info)
  (let ([xml (string-append
              (sdk-id info) ".xml")]
        [ex (sdk-config info)])
    (when (file-exists? xml)
      (delete-file xml))
    (call-with-output-file xml
      (lambda (out)
        (display "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" out)
        (display-xml/content (xexpr->xml ex) out)))))

(define (test info)
  (let ([ex1 (sdk-config info)])
    (if (xexpr? ex1)
        (display-xml/content (xexpr->xml ex1))
        (error 'Not-Xexpr "wrong"))))
