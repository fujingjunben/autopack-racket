#lang racket
(require net/uri-codec)
(require net/url)
(require json)
(require "post.rkt")

(provide (all-defined-out))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; interface for api, resource, executor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;
;;; api
;;;;;;;;
(define host "http://192.168.2.103:8080/auto-packing")
(define api-url (string-append host "/publish/apis"))
(define resource-url (string-append host "/publish/resources"))
(define executor-url (string-append host "/publish/executors"))
(define api-query
  ; get method
  (lambda ((alist '()))
    (query api-url alist)))

(define api-create
  ; post method
  (lambda (fields files)
    (create api-url fields files)))

(define api-update
  ; put method
  (lambda (id fields files)
    (update api-url id fields files)))

(define api-delete
  ; delete method
  (lambda (alist)
    (delete api-url alist)))

;;;;;;;;;;;;;;;;;;
;;; resource
;;;;;;;;;;;;;;;;;;
(define resource-query
  ; get method
  (lambda ((alist '()))
    (query resource-url alist)))

(define resource-create
  ; post method
  (lambda (fields files)
    (create resource-url fields files)))

(define resource-update
  ; put method
  (lambda (id fields files)
    (update resource-url id fields files)))

(define resource-delete
  ; delete method
  (lambda (alist)
    (delete resource-url alist)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; executor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define executor-query
  ; get method
  (lambda ((alist '()))
    (query executor-url alist)))

(define executor-create
  ; post method
  (lambda (fields files)
    (create executor-url fields files)))

(define executor-update
  ; put method
  (lambda (id fields files)
    (update executor-url id fields files)))

(define executor-delete
  ; delete method
  (lambda (alist)
    (delete executor-url alist)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; lib
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (->string bs)
  (if (bytes? bs)
      (bytes->string/utf-8 bs)
      bs))

(define (->bytes str)
  (cond
    [(string? str)
     (string->bytes/utf-8 str)]
    [(not str)
     #""]
    [else
     str]))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; query, create, update, delete
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define query
  (lambda (path params)
    (get (string->url
          (string-append
           path
           (if (null? params)
               ""
               (let* ([id (assoc 'id params)]
                      [rest (remove id params)])
                 (if id
                     (string-append "/" (cdr id) "?" (alist->form-urlencoded rest))
                     (string-append "?" (alist->form-urlencoded rest))))))))))

(define create
  (lambda (path fields files)
 (let-values ([(header body) (post-multipart fields files)])
   (post (string->url (string-append path))
         body
         header))))

(define update
  (lambda (path id fields files)
    (let-values ([(header body) (post-multipart fields files)])
      (display header)
      (post (string->url (string-append  path "/" id))
            body
            header))))

(define delete
  (lambda (path id)
    (del (string->url
          (string-append
           path
           "/"
           id)))))


(define get
  (lambda (url)
    (call/input-url url
                    get-pure-port
                    port->string)))

(define post
  (lambda (url data header)
    (call/input-url url
                    (lambda (url header)
                      (post-impure-port url data header))
                    port->string
                    header)))

(define del
  (lambda (url)
    (call/input-url url
                    delete-pure-port
                    port->string)))


;;;;;;;;;;;;;;;;;;
;; test
;;;;;;;;;;;;;;;;;;
(define api-key "e6822264802c9620d3ed8ce0dd8f4284")
(define site "https://api.flickr.com/services/rest/")

(define param `((resource_name . "百度")
                (version_name . "3.5.2")
                (inner_version . "2.0")
                (type . "GAME")
                (sdk_id . "AndBaiDu")
                (for_platform . "Android")
                (update_log . "test")
                (force_update . "true")
                (current_version . "true")))

(define param-string (alist->form-urlencoded param))

(define executor-param
  '((executor_name . "and_supersdk")
    (version_name . "1.1.2.0")
    (for_api . "6")
    (for_resource . "18")
    (sdk_id . "AndBaiDu")
    (for_lang . "Unity3D")
    (update_log . "init commit")))
