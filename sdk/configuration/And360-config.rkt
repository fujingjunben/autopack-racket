#lang racket
(require
  racket/date
  "sdk-module.rkt")

(provide info)

;; property, release and changelog
(define info
  ;;(property sdk-name sdk-version inner-version icon support-splash? unity-pack?)
  (sdk ([name "360"]
        [id "And360"]
        [channel "10003"]
        [version "1.1.8"]
        [inner-version "2.0"]
        [icon #f]
        [exit-dialog? #f]
        [unity-pack #t]
        
        ;; huawei parameters
        [param
         ;;(meta-data label description client-key server-key remote?)
         (list (meta-data "APP ID" "360 APP ID" "QHOPENSDK_APPID" "appId" #f)
               (meta-data "APP KEY" "360 APP KEY" "QHOPENSDK_APPKEY" "appKey" #f)
               (meta-data "APP PRIVATE KEY" "md5(app_secret +”#”+app_key)，小写" "QHOPENSDK_PRIVATEKEY" "" #f)
               (meta-data "微信APP ID"  "微信开放平台申请的 APPID" "QHOPENSDK_WEIXIN_APPID" "" #f)
               (meta-data "EXCHANGE RATE"  "货币与虚拟游戏币的兑换比例" "QHOPENSDK_EXCHANGERATE" "" #t)
               (meta-data "充值回调地址"  "充值回调地址" "QHOPENSDK_NOTIFYURI" "notifyUrl" #t)
               (meta-data "游戏名称"  "游戏名称" "QHOPENSDK_APPNAME" "" #t)
               (meta-data "APP SECRET" "360 APP SECRET" "" "secretKey" #f)
               )]
        
        [manifest '()]
        [resource '()]
        [attention '()])))

