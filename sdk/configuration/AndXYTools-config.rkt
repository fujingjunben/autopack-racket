#lang racket
(require
  racket/date
  "sdk-module.rkt")

(provide info)

;; 
(define info
  ;;(property sdk-name sdk-version inner-version icon support-splash? unity-pack?)
  (sdk ([name "xy助手"]
        [id "AndXYTools"]
        [channel "10045"]
        [version "2.1"]
        [inner-version "2.0"]
        [icon #t]
        [exit-dialog? #t]
        [unity-pack #t]
        [package-suffix ".xy"]
        
        [param
         (list
          (meta-data "APP ID" "请在后台申请" "XYSDK_APPID" "appId" #t)
          (meta-data "APP KEY" "请在后台申请" "XYSDK_APPKEY" "appKey" #t)
          (meta-data "游戏名称" "请填写游戏名称，必须与后台一致，以.xy结尾" "APP_NAME" "" #t)
          (meta-data "PAY KEY" "请在后台申请" "" "payKey" #f))]
        
        [manifest
         `((application
            ((activity ((android:name "com.wandoujia.oakenshield.activity.OakenshieldActivity"))
                       ((intent-filter
                         (data ((Revalue ((android:scheme "Wandoujia-PaySdk-'APP_ID'")))))))))))]
        [resource `()]
        [attention `()])))



