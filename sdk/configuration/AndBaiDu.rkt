((name "百度游戏")
 (id "AndBaiDu")
 (channel "AND0007")
 (version "3.6.3")
 (inner-version "2.0")
 (icon #t)
 (exit-dialog? #f)
 (unity-pack #t)
 (package-suffix ".BD")
 (meta-data
  (("APP ID" "请在后台申请" "APP_ID" #f "appId")
   ("APP KEY" "请在后台申请" "APP_KEY" #f "appKey")
   ("虚拟货币与人民币比率" "比如10:1，请填10" "BAIDU_RADIO" #f "")
   ("SECRET KEY" "请在后台申请" "" #f "secretKey")
   ("DOMAIN" "RELEASE：正式模式；DEBUG：测试模式" "BAIDU_DOMAIN" #f "")
   ("测试回调地址" "请填写支付回调地址" "BAIDU_DEBUG_CALLBACKURL" #f "")))
 (manifest
  ((application
    ((activity
      ((android:name
        "com.baidu.platformsdk.pay.channel.qqwallet.QQPayActivity"))
      ((intent-filter
        ((data ((Revalue ((android:scheme "qwallet'PACKAGENAME'")))))))))
    (activity
      ((android:name
        "com.baidu.platformsdk.pay.channel.ali.AliPayActivity"))
      ((intent-filter
        ((data ((Revalue ((android:scheme "bdpsdk'PACKAGENAME'")))))))))
    (provider
      ((android:name
        "com.duoku.platform.download.DownloadProvider"))
      ((Revalue ((android:authorities "'PACKAGENAME'")))))
    (provider
      ((android:name
        "mobisocial.omlib.service.OmlibContentProvider"))
      ((Revalue ((android:authorities "'PACKAGENAME'.provider")))))
    (provider
      ((android:name
        "glrecorder.Initializer"))
      ((Revalue ((android:authorities "'PACKAGENAME'.initializer")))))))))

 (resource ())
 (attention ()))
