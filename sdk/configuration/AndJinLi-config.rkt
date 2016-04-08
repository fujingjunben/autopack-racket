#lang racket
(require
  racket/date
  "sdk-module.rkt")

(provide info)

(define info
  (sdk ([name "金立"]
        [id "AndJinLi"]
        [channel "10016"]
        [version "3.0.7i"]
        [inner-version "2.0"]
        [icon #t]
        [exit-dialog? #f]
        [unity-pack #t]
        [package-suffix ".am"]
        
        [param
         ;;(meta-data key description local?)
         (list (meta-data "API KEY" "金立API KEY" "apiKey"  "" #t)
               (meta-data "SECRET KEY" "金立SECRET KEY" "secretKey"  "" #f)
               (meta-data "PRIVATE KEY" "金立PRIVATE KEY" "privateKey" "" #f)
               (meta-data "PUBLIC KEY" "金立PUBLIC KEY" "publicKey" "" #f))]
        [manifest '()]
        [resource '()]
        [attention '()])))



