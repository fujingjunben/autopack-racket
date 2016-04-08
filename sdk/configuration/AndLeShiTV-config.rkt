#lang racket
(require
  racket/date
  "sdk-module.rkt")

(provide info)

;; 
(define info
  (sdk ([name "乐视"]
        [id "AndLeShiTV"]
        [channel "10028"]
        [version "1.1.0"]
        [inner-version "2.0"]
        [icon #f]
        [exit-dialog? #t]
        [unity-pack #f]
        [package-suffix ".letv"]
        
        [param
         (list (meta-data "APP ID" "APP ID" "lepay_appid" "" #t)
               (meta-data "APP KEY" "APP KEY" "lepay_appkey" ""  #t)
               (meta-data "IS CHANGE ACCOUNT" "是否开启切换账号" "IS_CHANGE_ACCOUNT" "" #t)
               (meta-data "支付回调地址" "支付回调地址" "PAYNOTIFYURL" "" #t))]
        
        [manifest
         `()]
        [resource '()]
        [attention `()])))



