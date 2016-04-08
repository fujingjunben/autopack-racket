#lang racket

(provide (all-defined-out))

(define (string-in? target pattern)
  (define (string-car string)
    (string-ref string 0))
  
  (define (string-cdr string)
    (substring string 1))
  
  (let loop ((s target)
             (p pattern)
             (str target))
    (cond ((string=? "" p) #t)
          ((string=? "" s) #f)
          ((eq? (string-car s) (string-car p))
           (loop (string-cdr s) (string-cdr p) str))
          (else
           (loop (string-cdr str) pattern (string-cdr str))))))


(define (find-pattern-in-a-file path pattern [case-sensitive #f])
  (call-with-input-file path
    (lambda(in)
      (let loop ((line (read-line in)) (i 1) (lines empty))
        (if (eof-object? line)
            (if (empty? lines)
                #f
                lines)
            (let ((result
              (if case-sensitive
                  (string-in? line pattern)
                  (string-in? (string-upcase line) (string-upcase pattern)))))
              (if result
                (loop (read-line in) (add1 i) (cons (list i line) lines))
                (loop (read-line in) (add1 i) lines))))))))
  
(define (pattern-format file in-file)
  (displayln (string-append (make-string 10 #\;)
                            "BEGIN //" file
                            (make-string 10 #\;)))
  (for ([term (reverse in-file)])
    (displayln
     (string-append "line: "
                    (number->string (car term))
                    "\t"
                    (cadr term))))
  (displayln (string-append (make-string 10 #\;)
                            "END " file
                            (make-string 10 #\;))))


(define (file-extension? path my-ext)
  (let ((ext (filename-extension path)))
    (if ext
        (if (string=? (bytes->string/utf-8 ext) my-ext)
            #t
            #f)
        #f)))

(define (find-pattern-in-files path ext pattern sensitive)
  (letrec ((path-list (find-files (lambda (p) (file-extension? p ext)) path)))
    (if (empty? path-list)
        #f
        (let loop ((file-path path-list) (collects empty))
          (if (empty? file-path)
              collects
              (let ((in-file (find-pattern-in-a-file (car file-path) pattern sensitive)))
                (if in-file
                    (loop (cdr file-path) (cons (list (car file-path) in-file) collects))
                    (loop (cdr file-path) collects))))))))