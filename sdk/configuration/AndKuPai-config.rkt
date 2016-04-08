#lang racket
(require
  racket/date
  "sdk-module.rkt")

(provide info)

;; 
(define info
  (sdk ([name "酷派"]
        [id "AndKuPai"]
        [channel "10026"]
        [version "1.3.8"]
        [inner-version "2.0"]
        [icon #t]
        [exit-dialog? #t]
        [unity-pack #t]
        [package-suffix ".coolpad"]
        
        [param
         (list (meta-data "APP ID" "APP ID" "APP_ID" "client_id" #t)
               (meta-data "APP KEY" "APP KEY" "APP_KEY" "client_secret"  #t)
               (meta-data "支付回调地址" "支付回调地址" "PAYNOTIFYURL" ""  #t)
               (meta-data "WARES ID" "商品编码" "WARES_ID" "" #t)
               (meta-data "PAY KEY" "应用密钥（支付）" "PAY_KEY" "pub_key" #t))]
        
        [manifest '()]
        [resource '()]
        [attention `([(version "2.0")
                    ("manifest中APPDATA_APPKEY和APPDATA_CHANNEL不需要修改，直接从开发文档复制即可")])])))



