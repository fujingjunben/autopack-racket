#lang racket
(require
  racket/date
  "sdk-module.rkt")

(provide info)

;; 
(define info
  (sdk ([name "华为"]
        [id "AndHuaWei"]
        [channel "10013"]
        [version "1.6.3.53"]
        [inner-version "2.0"]
        [icon #f]
        [exit-dialog? #f]
        [unity-pack #t]
        [package-suffix ".huawei"]
        
        ;; huawei parameters
        [param
         ;;(meta-data label description client-key server-key remote?)
         (list (meta-data "APP ID" "华为APP ID" "HUAWEI_APP_ID" "" #t)
               (meta-data "CP ID" "华为CP ID" "HUAWEI_CP_ID" "" #t)
               (meta-data "PAY ID"  "华为PAY ID" "HUAWEI_PAY_ID" "" #t)
               (meta-data "PAY RSA PUBLIC" "华为支付公钥" "HUAWEI_PAY_RSA_PUBLIC" "publicKey" #t)
               (meta-data "PAY RSA PRIVATE" "华为支付私钥" "HUAWEI_PAY_RSA_PRIVATE" "" #t)
               (meta-data "BUO SECRET" "华为浮标秘钥" "HUAWEI_BUO_SECRET" "" #t)
               (meta-data "FLOAT TYPE" "浮标格式（1-应用级、2-网页级），int型" "HUAWEI_FLOAT_TYPE" "" #t))]
        
        [manifest '()]
        [resource '()]
        [attention `([(version "2.0")
                    ("如果华为点击悬浮窗崩溃，是因为缺少sdk中的android-support-v4，这个包含有华为自定义内容"
                     "切换账号的时候并不会弹出登陆界面，只有一个回调，返回的是切换账号失败的回调，请对该回调做处理，如跳转到游戏首页，然后重新初始化SuperSDK执行登陆。"
                     "包名必须以.huawei结尾")])])))



