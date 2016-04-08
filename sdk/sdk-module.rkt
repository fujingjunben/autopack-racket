#lang racket
(provide sdk
         sdk-name
         sdk-id
         sdk-channel
         sdk-version
         sdk-inner-version
         sdk-icon
         sdk-exit-dialog?
         sdk-unity-pack
         sdk-package-suffix
         sdk-param
         sdk-manifest
         sdk-resource
         sdk-attention
         meta-data
         meta-data-label
         meta-data-description
         meta-data-client-key
         meta-data-server-key
         meta-data-remote?
         res
         res-url
         res-description
         res-attention)

;; struct property contains

(struct property (sdk-name sdk-id channel-id sdk-version inner-version icon exit-dialog? unity-pack? package-suffix param manifest resource attention) #:mutable #:transparent)

;; manifest meta-data
;; @description: what is this parameter
;; @local: save local or upload to server
(struct meta-data (label description client-key server-key remote?) #:mutable #:transparent)


(struct resource-data (url description attention) #:mutable #:transparent)

(define property-function
  (hash 'name property-sdk-name
        'name! set-property-sdk-name!
        'id property-sdk-id
        'id! set-property-sdk-id!
        'channel property-channel-id
        'channel! set-property-channel-id!
        'version property-sdk-version
        'version! set-property-sdk-version!
        'inner-version property-inner-version
        'inner-version! set-property-inner-version!
        'icon property-icon
        'icon! set-property-icon!
        'exit-dialog? property-exit-dialog?
        'exit-dialog?! set-property-exit-dialog?!
        'unity-pack property-unity-pack?
        'unity-pack! set-property-unity-pack?!
        'package-suffix property-package-suffix
        'package-suffix! set-property-package-suffix!
        'param property-param
        'param! set-property-param!
        'manifest property-manifest
        'manifest! set-property-manifest!
        'resource property-resource
        'resource! set-property-resource!
        'attention property-attention
        'attention! set-property-attention!))

(define meta-data-function
  (hash 'label meta-data-label
        'label! set-meta-data-label!
        'description meta-data-description
        'description! set-meta-data-description!
        'client-key meta-data-client-key
        'client-key! set-meta-data-client-key!
        'server-key meta-data-server-key
        'server-key! set-meta-data-server-key!
        'remote? meta-data-remote?
        'remote?! set-meta-data-remote?!))

(define resource-data-function
  (hash 'url resource-data-url
        'url! set-resource-data-url!
        'description resource-data-description
        'description! set-resource-data-description!
        'attention resource-data-attention
        'attention! set-resource-data-attention!))

(define-syntax skeleton
  (syntax-rules ()
    [(_ type ht ((x e) ...))
     (let ([info type])
       (letrec ([x e] ...)
         ((hash-ref ht (string->symbol (string-append (symbol->string (syntax->datum #'x)) "!"))) info e) ...)
       info)]))

(define-syntax sdk
  (syntax-rules ()
    [(_ ([x e] ...))
     (skeleton (property "name" "id" "channel" "version" "inner-version" #f #f #t "suffix" '() '() '() '())
               property-function
               ([x e] ...))]))

(define-syntax meta
  (syntax-rules ()
    [(_ ([x e] ...))
     (skeleton (meta-data "label" "description" #f #f #t)
               meta-data-function
               ([x e] ...))]))

(define-syntax res
  (syntax-rules ()
    [(_ ([x e] ...))
     (skeleton (resource-data "url" "description" "attention")
               resource-data-function
               ([x e] ...))]))

;
;(define-syntax sdk
;  (syntax-rules ()
;    [(_ ((x e) ...))
;     (let ([info (property "name" "id" "channel" "version" "inner-version" #f #f #t '() '() '())])
;       (letrec ([x e] ...)
;           ((hash-ref property-function (string->symbol (string-append (symbol->string (syntax->datum #'x)) "!"))) info e) ...)
;       info)]))

(define (table-ref hs func)
  (hash-ref hs func))

(define (sdk-ref func)
  (table-ref property-function func))

;; for sdk
(define (sdk-name property)
  ((sdk-ref 'name) property))

(define (sdk-id property)
  ((sdk-ref 'id) property))

(define (sdk-channel property)
  ((sdk-ref 'channel) property))

(define (sdk-version property)
  ((sdk-ref 'version) property))

(define (sdk-inner-version property)
  ((sdk-ref 'inner-version) property))

(define (sdk-icon property)
  ((sdk-ref 'icon) property))

(define (sdk-exit-dialog? property)
  ((sdk-ref 'exit-dialog?) property))

(define (sdk-unity-pack property)
  ((sdk-ref 'unity-pack) property))

(define (sdk-package-suffix property)
  ((sdk-ref 'package-suffix) property))

(define (sdk-param property)
  ((sdk-ref 'param) property))

(define (sdk-manifest property)
  ((sdk-ref 'manifest) property))

(define (sdk-resource property)
  ((sdk-ref 'resource) property))

(define (sdk-attention property)
  ((sdk-ref 'attention) property))

;; for meta-data
(define (meta-ref func)
  (table-ref meta-data-function func))

(define (meta-key meta-data)
  ((meta-ref 'key) meta-data))

(define (meta-description meta-data)
  ((meta-ref 'description) meta-data))

(define (meta-local? meta-data)
  ((meta-ref 'local?) meta-data))

(define (meta-for-client? meta-data)
  ((meta-ref 'for-client?) meta-data))


;; for resource-data
(define (resource-ref func)
  (table-ref resource-data-function func))

(define (res-url resource-data)
  ((resource-ref 'url) resource-data))

(define (res-description resource-data)
  ((resource-ref 'description) resource-data))

(define (res-attention resource-data)
  ((resource-ref 'attention) resource-data))
