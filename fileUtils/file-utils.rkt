#lang racket

(provide
 lhk-copy-directory/files)


(define (raise-not-a-file-or-directory who path)
  (raise
   (make-exn:fail:filesystem
    (format "~a: encountered ~a, neither a file nor a directory"
            who
            path)
    (current-continuation-marks))))

(define (lhk-copy-directory/files src dest 
                                  #:keep-modify-seconds? [keep-modify-seconds? #f])
  (let loop ([src src] [dest dest])
    (cond [(file-exists? src)
           (copy-file src dest)
           (when keep-modify-seconds?
             (file-or-directory-modify-seconds
              dest
              (file-or-directory-modify-seconds src)))]
          [(directory-exists? src)
           (make-directory* dest)
           (for-each (lambda (e)
                       (loop (build-path src e)
                             (build-path dest e)))
                     (directory-list src))]
          [else (raise-not-a-file-or-directory 'copy-directory/files src)])))