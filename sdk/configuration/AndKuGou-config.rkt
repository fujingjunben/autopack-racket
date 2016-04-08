#lang racket
(require
  racket/date
  "sdk-module.rkt")

(provide info)

;; 
(define info
  ;;(property sdk-name sdk-version inner-version icon support-splash? unity-pack?)
  (sdk ([name "酷狗"]
        [id "AndKuGou"]
        [channel "10010"]
        [version "5.3.3"]
        [inner-version "2.0"]
        [icon #t]
        [exit-dialog? #f]
        [unity-pack #t]
        [package-suffix ".kugou"]
        
        ;; huawei parameters
        [param
         ;;(meta-data key description local?)
         (list (meta-data "MERCHANT ID" "MerchantId" "KG_MERCHANT_TD" "" #t)
               (meta-data "APP ID" "APP ID" "KG_APP_ID" "" #t)
               (meta-data "APP KEY" "APP KEY" "KG_APP_KEY" "key" #t)
               (meta-data "CODE" "注意：code内容里不要有换行" "KG_CODE" "" #t)
               (meta-data "FULL_SCREEN" "是否全屏" "KG_FULL_SCREEN" "" #t)
               (meta-data "RESTART ON SWITCH ACCOUNT" "切换账号是否重启" "KG_RESTART_ON_SWITCH_ACCOUNT" "" #t)
               (meta-data "HID PAY MODULE" "隐藏支付模块" "KG_HIDE_PAY_MODULE" "" #t)
               (meta-data "HIDE GAME CENTER" "隐藏游戏中心" "KG_HIDE_GAME_CENTER" "" #t)
               (meta-data "PUSH MESSAGE" "是否接受推送" "KG_PUSH_MESSAGE" "" #t)
               (meta-data "SUPPORT FORCE UPDATE" "是否支持强制更新" "KG_SUPPORT_FORCE_UPDATE" "" #t))]
        
        [manifest '()]
        
        [resource
         (list
          `([url "\\res\\raw\\channel"]
           [name "用于渠道分发数据的统计"]
           [description "注意：1、渠道号请填写整数；2、不要填写多行，包括空行；3渠道号若解析错误，会上传默认值0"]))]

        [attention `([(version "2.0") ("如果在初始化的时候把支付模块关闭，用户中心则不会显示消费记录，无法通过酷狗审查")])])))
