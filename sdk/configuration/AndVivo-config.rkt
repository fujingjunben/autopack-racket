#lang racket
(require
  racket/date
  "sdk-module.rkt")

(provide info)

;; 
(define info
  ;;(property sdk-name sdk-version inner-version icon support-splash? unity-pack?)
  (sdk ([name "VIVO"]
        [id "AndVivo"]
        [channel "10041"]
        [version "1.6.3.53"]
        [inner-version "2.0"]
        [icon #f]
        [exit-dialog? #f]
        [unity-pack #t]
        [package-suffix ".vivo"]
        
        ;; huawei parameters
        [param
         ;;(meta-data key description local?)
         (list (meta-data "APP ID" "请在后台申请" "VIVO_APP_ID" "appId" #t)
               (meta-data "CP ID" "请在后台申请" "" "cpId" #f)
               (meta-data "CP KEY" "请在后台申请" "" "appSecret" #f)
               (meta-data "调试模式" "true：调试模式；false：生产模式" "IS_DEBUG" ""　#t))]
        
        [manifest
         `((application 
            ((activity ((android:name "com.hutong.supersdk.wxapi.WXPayEntryActivity"))
                       ((Revalue ((android:name "'PACKAGENAME'.wxapi.WXPayEntryActivity")))))
             (activity ((android:name "com.bbk.payment.tenpay.VivoQQPayResultActivity"))
                       ((intent-filter
                         ((data ((Revalue ((android:scheme "qwallet'PACKAGENAME'"))))))))))))]
        
        [resource '()]
        [attention '()])))



