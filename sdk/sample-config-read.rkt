(define info
  ;;(property sdk-name sdk-version inner-version icon support-splash? unity-pack?)
  (sdk ([name "华为"]
        [id "AndSample"]
        [channel "10010"]
        [version "1.6.3.53"]
        [inner-version "2.0"]
        [icon #t]
        [exit-dialog? #f]
        [unity-pack #t]
        [package-suffix ".huawei"]
        
        ;; huawei parameters
        [param
         ;;(meta-data key description local?)
         (list (meta-data "APP ID" "华为APP ID" "HUAWEI_APP_ID" "" #t)
               (meta-data "CP ID" "华为CP ID" "HUAWEI_CP_ID" "" #t)
               (meta-data "PAY ID"  "华为PAY ID" "HUAWEI_PAY_ID" "" #t)
               (meta-data "PAY RSA PUBLIC" "华为支付公钥" "HUAWEI_PAY_RSA_PUBLIC" "publicKey" #t)
               (meta-data "PAY RSA PRIVATE" "华为支付私钥" "HUAWEI_PAY_RSA_PRIVATE" "" #t)
               (meta-data "BUO SECRET" "华为浮标秘钥" "HUAWEI_BUO_SECRET" "" #t)
               (meta-data "FLOAT TYPE" "浮标格式（1-应用级、2-网页级），int型" "HUAWEI_FLOAT_TYPE" "" #t))]
        
        [manifest
         `((uses-permission ((Revalue ((adroid:name "android.permission.INTERNET")))))
           (application 
                       ((activity ((android:name "value"))
                                  ((intent ((android:name "value"))
                                           ((Revalue ((android:xxx "cn.m4399.operate.ui.'BAIDU_DOMAIN1'.LoginActivity")))))))
                        (activity ((android:name "value"))
                                  ((intent ((android:name "value"))
                                           ((Revalue ((android:xxx "cn.m4399.operate.ui.'BAIDU_DOMAIN1'.LoginActivity"))))))))))]
        
        [resource
         (list
          `([url "\\assets\\a.bin"]
           [name "导入签名文件"]
           [description "tooltips"]))]
        [attention `([(version "2.0") ("如果在初始化的时候把支付模块关闭，用户中心则不会显示消费记录，无法通过酷狗审查")])])))



