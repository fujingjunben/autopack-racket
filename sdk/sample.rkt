#lang racket

(define pattern (regexp "192.168.2.150:8080"))
(define xml (file->string "AndroidManifest.xml"))

