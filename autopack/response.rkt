#lang racket
(require json)
(provide (all-defined-out))

;;; get api id
(define (get-api-id ht)
  (get-id ht))

;;; get api version
(define (get-api-version ht)
  (hash-ref ht 'api_version))

;;; get resource id
(define (get-resource-id ht)
  (get-id ht))

(define (get-resource-inner-version ht)
  (hash-ref ht 'inner_version))

;;; get executor id
(define (get-executor-id ht)
  (get-id ht))

;;; get api hash table
(define (get-api-table apis)
  (get-table apis 'apis))

;;; get resource hash table
(define (get-resource-table resources)
  (get-table resources 'resources))

;;; get executore hash table
(define (get-executor-table executors)
  (get-table executors 'executors))

(define (get-id ht)
  (hash-ref ht 'id))

(define (get-table ht type)
  (car (hash-ref ht type)))