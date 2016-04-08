((name "360手机助手")
 (id "And360")
 (channel "AND0003")
 (version "1.1.8")
 (inner-version "2.1")
 (icon #f)
 (exit-dialog? #t)
 (unity-pack #t)
 (package-suffix ".qihu")
 (meta-data
  (("APP ID" "360 APP ID" "QHOPENSDK_APPID" #f "appId")
   ("APP KEY" "360 APP KEY" "QHOPENSDK_APPKEY" #f "appKey")
   ("APP PRIVATE KEY"
    "md5(app_secret +”#”+app_key)，小写"
    "QHOPENSDK_PRIVATEKEY"
    #f
    "")
   ("微信APP ID" "微信开放平台申请的 APPID" "QHOPENSDK_WEIXIN_APPID" #f "")
   ("EXCHANGE RATE" "货币与虚拟游戏币的兑换比例" "QHOPENSDK_EXCHANGERATE" #t "")
   ("充值回调地址" "充值回调地址" "QHOPENSDK_NOTIFYURI" #t "notifyUrl")
   ("游戏名称" "游戏名称" "QHOPENSDK_APPNAME" #t "")
   ("APP SECRET" "360 APP SECRET" "" #f "secretKey")))
 (manifest 
  ((application ((activity ((android:name "com.hutong.supersdk.wxapi.WXEntryActivity"))
                  ((Revalue ((android:name "'PACKAGENAME'.wxapi.WXEntryActivity")))))))))
 (resource ())
 (attention ()))
