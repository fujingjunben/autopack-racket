#lang racket
(require
  racket/date
  "sdk-module.rkt")

(provide info)

;; 
(define info
  (sdk ([name "拇指玩"]
        [id "AndMuZhiWan"]
        [channel "10032"]
        [version "3.0.9"]
        [inner-version "2.0"]
        [icon #f]
        [exit-dialog? #t]
        [unity-pack #t]
        [package-suffix ".mzw"]
        
        [param
         (list (meta-data "APP KEY" "APP KEY" "MZWAPPKEY" "appKey"  #t)
               (meta-data "DEBUG" "是否开启调试模式" "DEBUG" "" #t)
               (meta-data "签名校验串" "签名校验串" "" "signKey" #f))]
        
        [manifest '()]
        [resource '()]
        [attention '()])))



