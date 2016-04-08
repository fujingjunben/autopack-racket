#lang racket
(require
  racket/date
  "sdk-module.rkt")

(provide info)

;; 
(define info
  ;;(property sdk-name sdk-version inner-version icon support-splash? unity-pack?)
  (sdk ([name "百度"]
        [id "AndBaiDu"]
        [channel "10007"]
        [version "3.5.2"]
        [inner-version "2.0"]
        [icon #t]
        [exit-dialog? #f]
        [unity-pack #t]
        [package-suffix ".BD"]
        
        [param
         (list
          (meta-data "APP ID" "请在后台申请" "APP_ID" "appId" #f)
          (meta-data "APP KEY" "请在后台申请" "APP_KEY" "appKey" #f)
          (meta-data "虚拟货币与人民币比率" "比如10:1，请填10" "BAIDU_RADIO" "" #f)
          (meta-data "SECRET KEY" "请在后台申请" "" "secretKey" #f)
          (meta-data "DOMAIN" "REALEASE：正式模式；DEBUG：测试模式" "BAIDU_DOMAIN" "" #f)
          (meta-data "测试回调地址" "请填写支付回调地址" "BAIDU_DEBUG_CALLBACKURL" "" #f))]
        
        [manifest
         `((application
            ((activity ((android:name "com.baidu.platformsdk.pay.channel.qqwallet.QQPayActivity"))
                       ((intent-filter
                         ((data ((Revalue ((android:scheme "qwallet'PACKAGENAME'"))))))))))))]
        [resource `()]
        [attention `()])))



