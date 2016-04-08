#lang racket
(require xml)
(provide eat-xml)

(define eat-xml
  (lambda (AndroidManifest)
    (call-with-input-file AndroidManifest
      (lambda (in)
        (read-xml in)))))