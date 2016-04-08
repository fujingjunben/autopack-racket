#lang racket
(provide (all-defined-out))
;; struct property contains
;; @sdk-name
;; @sdk-version
;; @inner-version
;; @support-splash?
;; @unity-pack?

(struct property (name id version inner-version icon? own-splash? unity-pack? param manifest resource) #:mutable)

;; manifest meta-data
;; @key: android-name
;; @description: what is this parameter
;; @local: save local or upload to server
(struct meta-data (key description local))

;; replacement of manifest
;; @name: node name
;; @attribute: list of attribute
;; @content: list of content
(struct resource-data (url name description))

(define-syntax sdk
  (syntax-rules ()
    [(_ ((x e) ...) b ...)
     (let ([info (property #t #t #t #t #f #f #t '() '() '())])
       (letrec ([x e] ...)
         ((eval (string->symbol
                 (string-append "set-property-"
                                (symbol->string (syntax->datum #'x)) "!"))) info e) ...)
       info)]))

(define (sdk-name info)
  (property-name info))

(define (sdk-id info)
  (property-id info))

(define (sdk-version info)
  (property-version info))

(define (sdk-inner-version info)
  (property-inner-version info))

(define (sdk-icon? info)
  (property-icon? info))

(define (sdk-splash? info)
  (property-own-splash? info))

(define (sdk-unity-pack? info)
  (property-unity-pack? info))

(define (sdk-param info)
  (property-param info))

(define (sdk-manifest info)
  (property-manifest info))

(define (sdk-resource info)
  (property-resource info))