#lang racket
(require
  racket/date
  "sdk-module.rkt")

(provide info)

;; 
(define info
  ;;(property sdk-name sdk-version inner-version icon support-splash? unity-pack?)
  (sdk ([name "应用宝"]
        [id "AndYingYongBao"]
        [channel "10050"]
        [version "midas1.5+msdk2.5.4"]
        [inner-version "2.0"]
        [icon #f]
        [exit-dialog? #f]
        [unity-pack #t]
        [package-suffix ".yyb"]
        
        ;; huawei parameters
        [param
         ;;(meta-data key description local?)
         (list (meta-data "QQ APP ID" "QQ APP ID" "qqAppId" "qqAppId" #t)
               (meta-data "QQ APP KEY" "QQ APP KEY" "qqAppKey" "qqAppKey" #t)
               (meta-data "微信 APP ID"  "微信 APP ID" "wxAppId" "wxAppId" #t)
               (meta-data "微信 APP KEY" "微信 APP KEY" "wxAppKey" "wxAppKey" #t)
               (meta-data "offer Id" "支付 ID" "offerId" "" #t)
               (meta-data "msdk key" "MSDK KEY" "AppKey" "midasAppKey" #t)
               (meta-data "正式模式还是测试模式" "release为正式模式；debug为测试模式" "mode" "" #t)
               (meta-data "是否输出日志" "true：输出日志；false：不输出日志" "isDebug" "" #t)
               (meta-data "是否定额支付" "支付界面的充值金额是否可以修改，true：可以修改；false：不可以修改" "isFixedPay" "" #t)
               (meta-data "应用宝虚拟货币兑换率" "请填数字" "" "balanceExchangeRate" #f))]
        
        [manifest
         `((application 
            ((activity ((android:name "com.tencent.tauth.AuthActivity")
                        (android:launchMode="singleTask")
                        (android:noHistory "true"))
                       ((intent-filter
                         ((data
                           ((Revalue ((android:scheme "tencent'qqAppId'")))))))))
             (activity ((android:excludeFromRecents "true")
                        (android:exported "true")
                        (android:label "WXEntryActivity")
                        (android:launchMode "singleTop"))
                       ((Revalue ((android:name "'PACKAGENAME'.WXEntryActivity")))))
             (activity ((android:excludeFromRecents "true")
                        (android:exported "true")
                        (android:label "WXEntryActivity")
                        (android:launchMode "singleTop"))
                       ((Revalue ((android:tasdkAffinity "'PACKAGENAME'.diff")))))
             (activity ((android:excludeFromRecents "true")
                        (android:exported "true")
                        (android:label "WXEntryActivity")
                        (android:launchMode "singleTop"))
                       ((intent-filter
                         ((data ((Revalue ((android:scheme "'wxAppId'")))))))))
             (activity ((android:name "com.tencent.midas.qq.APMidasQQWalletActivity"))
                       ((intent-filter
                         ((data ((Revalue ((android:scheme "qwallet'qqAppId'"))))))))))))]
        [resource
         (list
          `([url "\\assets\\msdkconfig.ini"]
            [name "配置文件"]
            [description "切换正式环境和测试环境"]))]
        [attention `()])))



