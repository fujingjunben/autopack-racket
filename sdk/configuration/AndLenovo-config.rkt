#lang racket
(require
  racket/date
  "sdk-module.rkt")

(provide info)

;; 
(define info
  (sdk ([name "联想"]
        [id "AndLenovo"]
        [channel "10026"]
        [version "2.4.2.1"]
        [inner-version "2.0"]
        [icon #t]
        [exit-dialog? #f]
        [unity-pack #t]
        [package-suffix ".lenovo"]
        
        [param
         (list (meta-data "APP ID" "lenovo open appid" "lenovo.open.appid" "realm" #t)
               (meta-data "APP KEY" "支付密钥" "LENOVO_APP_KEY" "pub_key"  #t))]
        
        [manifest
         `((application
            ((receiver ((android:name "com.lenovo.lsf.gamesdk.receiver.GameSdkReceiver"))
                       ((intent-filter
                         ((action ((Revalue ((android:name "'APP_ID'")))))))))
             (receiver ((android:name "com.lenovo.lsf.gamesdk.receiver.GameSdkReceiver"))
                       ((intent-filter
                         ((category ((Revalue ((android:name "'PACKAGENAME'")))))))))
             (receiver ((android:name "com.lenovo.lsf.gamesdk.receiver.GameSdkAndroidLReceiver" ))
                       ((intent-filter
                         ((category ((Revalue ((android:name "'PACKAGENAME'"))))))))))))]
        [resource '()]
        [attention `()])))



