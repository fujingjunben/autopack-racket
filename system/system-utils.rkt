#lang racket
(provide (all-defined-out))

(define (print-to-current-port execute)
  (let* ([out-str-port (open-output-string)]
         [err-str-port (open-output-string)]
         [system-rv
          (parameterize ((current-output-port out-str-port) (current-error-port err-str-port))
            execute)])
    (values system-rv (get-output-string out-str-port) (get-output-string err-str-port))))