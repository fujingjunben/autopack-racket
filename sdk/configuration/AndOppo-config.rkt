#lang racket
(require
  racket/date
  "sdk-module.rkt")

(provide info)

;; 
(define info
  (sdk ([name "Oppo"]
        [id "AndOppo"]
        [channel "10033"]
        [version "2.0.0"]
        [inner-version "2.0"]
        [icon #f]
        [exit-dialog? #t]
        [unity-pack #t]
        [package-suffix ".nearme.gamecenter"]
        
        [param
         (list
          (meta-data "APP ID" "APP ID" "APP_ID" "" #t)
          (meta-data "APP KEY" "APP KEY" "APP KEY" "appKey"  #t)
          (meta-data "APP SECRET" "APP SECRET" "APP_SECRET" "appSecret" #t)
          (meta-data "DEBUG" "是否开启调试模式" "BUGMODE" "" #t)
          (meta-data "支付回调地址" "支付回调地址" "PAYNOTIFYURL" "" #t)
          (meta-data "是否为单机游戏" "true为单机游戏；false为网游" "IS_ONLINE" "" #t))]
        
        [manifest '()]
        [resource '()]
        [attention '()])))



