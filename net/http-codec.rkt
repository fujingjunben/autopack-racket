#lang racket
(require net/base64
         net/uri-codec
         file/md5)

(provide (all-defined-out))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; libs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

(define post-multipart
  (lambda (fields (files null))
    (let-values ([(content-type body) (encode-multipart-formdata fields files)])
      (let ([header (list (format "Content-Type: ~a" content-type)
                          (format "Content-Length: ~a" (bytes-length body)))])
        (values header body)))))

(define encode-multipart-formdata
  (lambda (fields files)
    ; field is a list of (name value) elements for regular form fields
    ; files is a list of (sequence of (name filename value) elements for data to uploaded as files
    ; Return (content-type body)
    (let* ([boundary (bytes->string/utf-8 (md5 (number->string (current-seconds))))]
           [CRLF #"\r\n"]
           [fields-body
            (if (null? fields) #""
                (apply bytes-append
                       (for/list ([item fields])
                         (let ([key (first item)]
                               [value (second item)])
                           (apply bytes-append
                                  (map (lambda (item)
                                         (bytes-append item CRLF))
                                       (map ->bytes 
                                            (list (format "--~a" boundary)
                                                  (format "Content-Disposition: form-data; name=\"~a\"" key)
                                                  ""
                                                  value))))))))]
           [files-body
            (if (null? files) #""
                (apply bytes-append
                       (for/list ([item files])
                         (let ([name (first item)]
                               [filename (second item)]
                               [filepath (third item)])
                           (apply bytes-append
                                  (map (lambda (item)
                                         (bytes-append item CRLF))
                                       (append
                                        (map ->bytes
                                             (list (format "--~a" boundary)
                                                   (format "Content-Disposition: form-data;name=\"~a\";filename=\"~a\"" name filename)
                                                   (format "Content-Type: ~a" (content-type filename))
                                                   ""))
                                        (list (file->bytes filepath)))))))))]
           [endline (->bytes (format "--~a--~a~a" boundary CRLF CRLF))])
      (values (format "multipart/form-data; boundary=~a" boundary)
              (bytes-append fields-body files-body endline)))))

(define (content-type filename)
  (match (filename-extension filename)
    [#"zip" "application/zip"]
    [(or #"txt" #"rkt") "txt/plain"]))

(define (alist->form-urlencoded args)
  (string-join
   (for/list ([arg (in-list args)])
     (define name  (form-urlencoded-encode (first arg)))
     (define value (and (cdr arg) (form-urlencoded-encode (second arg))))
     (if value (string-append name "=" value) name))
   (if (memq (current-alist-separator-mode) '(semi semi-or-amp)) ";" "&")))

(define (url-sign alist)
  (->base64 alist))

(define (->base64 alist)
  (string-join
   (map (lambda (pair)
          (let ([key (first pair)]
                [value (second pair)])
            (format "~a=~a" key (->string (base64-encode (->bytes value) #"")))))
        (sort alist #:key car string<?))
   ""))

