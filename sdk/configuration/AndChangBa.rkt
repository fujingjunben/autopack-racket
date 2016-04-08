((name "唱吧")
 (id "AndChangBa")
 (channel "AND0008")
 (version "1.3")
 (inner-version "2.0")
 (icon #t)
 (exit-dialog? #f)
 (unity-pack #t)
 (package-suffix ".changba")
 (meta-data
   (("redirectUri" "授权回调地址" "redirectUri" #t "")
    ("consumerKey" "授权回调地址冒号前的部分" "consumerKey" #t "")
    ("consumerSecret" "游戏私钥" "consumerSecret" #t "secret")
    ("应用编号" "即 PAY_ID，请在后台申请" "APP_ID" #t "id")
    ("PLATP_KEY" "平台公钥，用于支付" "PAY_PKEY" #t "pubKey")
    ("APPV_KEY" "应用私钥" "PAY_VKEY" #t "priKey")))
 (manifest
  ((application
    ((activity ((android:name "com.changba.activity.OAuthActivity"))
              ((intent-filter
                ((data 
                  ((Revalue ((android:scheme "'consumerKey'")))))))))))))
 (resource ())
 (attention ()))
