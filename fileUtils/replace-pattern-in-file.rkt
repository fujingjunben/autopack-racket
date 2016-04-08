#lang racket
(provide (all-defined-out))

;; location for file which will be updated
(define path "e:/develop/git-local/workspace/supersdk-client/Android/SuperSDK-Client")
;; repace insert with pattern in path
(define (update-file path pattern insert)
  (let* ([reg (regexp pattern)]
         [after (regexp-replace reg (file->string path) insert)])
  (call-with-input-file path
    (lambda (out)
      (display after out))
    #:exists 'replace)))

;; get file lists from path


