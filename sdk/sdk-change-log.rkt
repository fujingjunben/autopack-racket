#lang racket
(require "sdk-module.rkt")
(provide (all-defined-out))

;; change-log
;; @name: sdk-name
;; @description: sdk description
;; @list-of-item: log-item
(struct change-log (name description content))

;; @sdk-version
;; @inner-version
;; @timestamp
;; @change: list of string
;; @fix: list of string
;; @add: list of string
(struct log (sdk-version inner-version timestamp change fix add))