#lang racket
(require
  racket/date
  "sdk-module.rkt")

(provide info)

;; 
(define info
  ;;(property sdk-name sdk-version inner-version icon custom-splash? unity-pack? package-suffix)
  (sdk ([name "游龙"]
        [id "AndYouLong"]
        [channel "10049"]
        [version "1.7"]
        [inner-version "2.0"]
        [icon #f]
        [exit-dialog? #f]
        [unity-pack #t]
        [package-suffix ".yl"]
        
        ;; huawei parameters
        [param
         ;;(meta-data key description local?)
         (list (meta-data "APP ID" "请在后台申请" "PID" "pid" #t)
               (meta-data "APP KEY" "请在后台申请" "PKEY" "pKey" #t))]
        
        [manifest '()]
        
        [resource '()]
        [attention '()])))



