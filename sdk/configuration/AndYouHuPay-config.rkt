#lang racket
(require
  racket/date
  "sdk-module.rkt")

(provide info)

;; 
(define info
  (sdk ([name "琵琶"]
        [id "AndYouHuPay"]
        [channel "10047"]
        [version "2.6"]
        [inner-version "2.0"]
        [icon #t]
        [exit-dialog? #t]
        [unity-pack #t]
        [package-suffix ".erhu"]
        
        [param
         (list
          (meta-data "APP ID" "应用ID" "appId" "appId" #t)
          (meta-data "merchantId" "商家ID" "merchantId" "merchantId" #t)
          (meta-data "merchantAppId" "游戏ID" "merchantAppId" "merchantAppId" #t)
          (meta-data "privateKey" "私钥" "privateKey" "appKey" #t))]
        
        [manifest '((application
                     ((service ((android:name "com.tencent.android.tpush.rpc.XGRemoteService"))
                               ((intent-filter ((action ((Revalue ((android:name "'PACKAGENAME'.PUSH_ACTION"))))))))))))]
        [resource '()]
        [attention '()])))



