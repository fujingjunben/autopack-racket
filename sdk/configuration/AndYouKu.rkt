((name "优酷")
 (id "AndYouKu")
 (channel "AND0048")
 (version "2.4")
 (inner-version "2.0")
 (icon #f)
 (exit-dialog? #f)
 (unity-pack #t)
 (package-suffix ".youku")
 (meta-data
  (("APP ID" "请在后台申请" "YKGAME_APPID" #f "")
   ("APP KEY" "请在后台申请" "YKGAME_APPKEY" #f "appKey")
   ("APP SECRET" "请在后台申请" "YKGAME_PRIVATEKEY" #f "")
   ("PAY KEY" "请在后台申请" "" #f "payKey")
   ("游戏名称" "请于后台保持一致" "YKGAME_APPNAME" #f "")
   ("支付回调地址" "请与后台保持一致" "PAYNOTIFYURL" #t "")))
 (manifest
  ((application
    ((activity
      ((android:name "com.hutong.supersdk.wxapi.WXPayEntryActivity"))
          ((Revalue ((android:name "'PACKAGENAME'.wxapi.WXPayEntryActivity")))))))))
 (resource ())
 (attention ()))
