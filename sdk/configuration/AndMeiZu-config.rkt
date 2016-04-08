#lang racket
(require
  racket/date
  "sdk-module.rkt")

(provide info)

;; 
(define info
  (sdk ([name "魅族"]
        [id "AndMeiZu"]
        [channel "10029"]
        [version "2.1"]
        [inner-version "2.0"]
        [icon #f]
        [exit-dialog? #t]
        [unity-pack #t]
        [package-suffix ".mz"]
        
        [param
         (list
          (meta-data "APP ID" "APP ID" "APP_ID" "appID" #t)
          (meta-data "APP KEY" "APP KEY" "APP KEY" "" #t)
          (meta-data "APP SECRET" "APP SECRET" "" "appSecret" #f))]
        
        [manifest '()]
        [resource '()]
        [attention '()])))



