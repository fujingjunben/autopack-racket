#lang racket
(provide (all-defined-out))

(define-struct configuration
  (name id channel version inner-version icon exit-dialog?
        unity-pack? package-suffix meta-data manifest resource attention)
  #:transparent)