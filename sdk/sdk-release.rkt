#lang racket
(require "sdk-module.rkt")
(provide (all-defined-out))
;; release doc
;; @name: sdk-name
;; @release-items
(struct release (name content))

;; release items
;; @inner-version
;; @items: list of items which should be cared about
(struct content (inner-version item))