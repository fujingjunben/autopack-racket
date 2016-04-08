#lang racket
(require net/url
         net/base64
         file/md5
         json
         "../net/http-codec.rkt"
         "../sdk/sdk-configuration.rkt")

(provide (all-defined-out))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; interface for api, resource, executor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;
;;; api
;;;;;;;;
(define host150 "http://192.168.2.150/auto-packing")
(define host211 "http://autopacking.sail2world.com/auto-packing")
(define signKey "239n483n9&*(%)@#Nsdf0912k")

(define (select ip)
  (let* ([host (if (string=? ip "150")
                   host150
                   host211)]
         [api-url (string-append host "/publish/apis")]
         [resource-url (string-append host "/publish/resources")]
         [executor-url (string-append host "/publish/executors")])
    (values host api-url resource-url executor-url)))
                   

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; query, create, update, delete
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define query
  (lambda (path params)
    (displayln path)
      (get (string->url
            (string-append
             path
             (let* ([id (assoc "id" params)]
                    [rest (remove id params)]
                    [after-sign (add-sign-time rest)])
               (if id
                   (string-append "/" (second id) "?" (alist->form-urlencoded after-sign))
                   (string-append "?" (alist->form-urlencoded after-sign)))))))))

(define create
  (lambda (path fields files)
    (displayln path)
;    (displayln (format "FIELDS: ~a" fields))
;    (displayln (format "FILES: ~a" files))
    (let-values ([(header body) (post-multipart (add-sign-time fields) files)])
      (post (string->url (string-append path))
            body
            header))))

(define update
  (lambda (path id fields files)
    (displayln (string-append path "/" id))
;    (displayln fields)
;    (displayln files)
    (let-values ([(header body) (post-multipart (add-sign-time fields) files)])
      (post (string->url (string-append  path "/" id))
            body
            header))))

(define delete
  (lambda (path id)
    (del (string->url
          (string-append
           path
           "/"
           id
           "?"
           (alist->form-urlencoded (add-sign-time '())))))))


(define get
  (lambda (url)
    (call/input-url url
                    get-pure-port
                    (lambda (port)
                      (string->jsexpr (port->string port))))))

(define post
  (lambda (url data header)
    (call/input-url url
                    (lambda (url header)
                      (post-pure-port url data header))
                    (lambda (port)
                      (displayln (port->string port))
                      (string->jsexpr (port->string port)))
                    header)))

(define del
  (lambda (url)
    (call/input-url url
                    delete-pure-port
                    (lambda (port)
                      (string->jsexpr (port->string port))))))


;;;;;;;;;;;;;;;;;;
;; test
;;;;;;;;;;;;;;;;;;
(define param `(("resource_name" "百度")
                ("version_name" "3.5.2")
                ("inner_version" "2.0")
                ("type" "GAME")
                ("sdk_id" "AndBaiDu")
                ("for_platform" "Android")
                ("update_log" "test")
                ("force_update" "true")
                ("current_version" "true")
                ("time" ,(number->string (current-milliseconds)))))

(define param-string (alist->form-urlencoded param))

(define executor-param
  '(("executor_name" "and_supersdk")
    ("version_name" "1.1.2.0")
    ("for_api" "6")
    ("for_resource" "18")
    ("sdk_id" "AndBaiDu")
    ("for_lang" "Unity3D")
    ("update_log" "init commit")))

(define (add-sign-time params)
  (let* ([time (number->string (current-milliseconds))]
         [before-sign (cons `("time" ,time) params)]
         [signature (->string (md5 (string-append signKey (url-sign before-sign) signKey)))]
         [after-sign (cons `("sign" ,signature) before-sign)])
    after-sign))

;; get resource version
(define (get-newest-res alist)
  (get-newest-version alist 'inner_version))

(define (get-newest-executor alist)
  (get-newest-version alist 'version_name))

(define (get-res-version-code alist)
  (hash-ref (get-newest-res alist) 'inner_version))

(define (get-executor-version-code alist)
  (hash-ref (get-newest-executor alist) 'version_name))

(define (get-newest-version alist key)
  (car (sort alist #:key (lambda (item)
                           (hash-ref item key)) string>=?)))