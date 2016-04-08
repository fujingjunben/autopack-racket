#lang racket
(require net/uri-codec)
(require net/url)
(require json)
(require net/http-client)

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
  (lambda (data #:header (header '("Content-Type: application/x-www-form-urlencoded")))
    (create api-url data header)))

(define api-update
  ; put method
  (lambda (params data #:header (header '("Content-Type: application/x-www-form-urlencoded")))
    (update api-url params data header)))

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
  (lambda (data #:header (header '()))
    (create resource-url data header)))

(define resource-update
  ; put method
  (lambda (data #:header (header '((charset . "UTF-8"))))
    (update resource-url data header)))

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
  (lambda (data #:header (header '("Content-Type: multipart/form-data")))
    (create executor-url data header)))

(define executor-update
  ; put method
  (lambda (params data #:header (header '("Content-Type: application/x-www-form-urlencoded")))
    (update executor-url params data header)))

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
  (lambda (path data header)
    (post path data header)))

(define update
  (lambda (path data header)
    path
    (let* ([id (assoc 'id data)]
           [rest (remove id data)])
      (post (string-append path "/" (cdr id)) rest header))))

(define delete
  (lambda (path params)
    (del (string->url
          (string-append
           path
           (let* ([id (assoc 'id params)]
                  [rest (remove id params)])
             (if (null? rest)
                 (string-append "/" (cdr id))
                 (string-append "/" (cdr id) "?" (alist->form-urlencoded rest)))))))))

(define post
  (lambda (url data header)
    (net-op url (make-form data) (make-header header))))

(define del
  (lambda (url)
    (call/input-url url
                    delete-pure-port
                    port->string)))


(define get
  (lambda (url)
    (call/input-url url
                    get-pure-port
                    port->string)))





;;;;;;;;;;;;;;;;;;
;; test
;;;;;;;;;;;;;;;;;;
(define api-key "e6822264802c9620d3ed8ce0dd8f4284")
(define site "https://api.flickr.com/services/rest/")

(define param `((resource_name . "华为")
                (version_name . "1.1.8")
                (inner_version . "2.0")
                (type . "GAME")
                (sdk_id . "AndHuaWei")
                (for_platform . "Android")
                (update_log . "test")
                (force_update . "true")
                (current_version . "false")
                (file . "@And360.zip")))

(define curl (find-executable-path "curl.exe"))
(define gen-params
  (lambda (header? sep alist)
    (if (null? alist)
        '()
        (flatten (map (lambda (pair)
                        (list (if header?
                                  "-H"
                                  "-F")
                               (string-append (symbol->string (car pair)) sep (cdr pair))))
                      alist)))))

(define make-form
  (lambda (forms)
    (gen-params #f "=" forms)))

(define make-header
  (lambda (headers)
    (gen-params #t ":" headers)))

(define (net-op url param header)
  (displayln param)
  (apply system*/exit-code (cons curl (append param header (list url)))))