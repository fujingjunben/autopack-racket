#lang racket
(require (prefix-in Constant: "../constant.rkt"))

;; accetp data from server

(define AResData (make-hash))

(define (get-status ht)
  (hash-ref ht Constant:STATUS))

(define (get-time ht)
  (hash-ref ht Constant:TIME))

(define (get-executors ht)
  (hash-ref ht Constant:EXECUTORS))