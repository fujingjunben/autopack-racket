#lang racket

; find-gui.rkt
(require
  racket/gui
  "find.rkt")


(define path ".")
(define dir "")
(define message "")
(define ext "")
(define sensitive #f)

(define frame (new frame%
                   [label "find pattern in files"]
                   [width 300]
                   [height 300]))

(define path-panel (new horizontal-panel%
                        [parent frame]))

(define choice-panel (new horizontal-panel%
                          [parent frame]))

(define path-text (new text-field%
                       [label "path"]
                       [parent path-panel]
                       ))
(define choice-text (new text-field%
                         [label "file extension"]
                         [parent choice-panel]))

(define sensitive-check (new check-box%
                            [label "case sensitive"]
                            [parent choice-panel]
                            [value #t]))

(define confirm
  (new button%
       [label "confirm"]
       [parent path-panel]
       [callback 
        (lambda (b e)
          (set! path (send path-text get-value))
          (send dirs-message set-label
                 (find-pattern-in-files path "rkt" "define")))]))

(define dirs-message (new message%
                          [label "nothing"]
                          [parent frame]
                          [auto-resize #t]))

(send frame show #t)