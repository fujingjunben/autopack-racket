((name "VIVO")
 (id "AndVIVO")
 (channel "AND0041")
 (version "账号4.1.2;支付3.1.4")
 (inner-version "2.0")
 (icon #f)
 (exit-dialog? #f)
 (unity-pack #t)
 (package-suffix ".vivo")
 (meta-data
  (("APP ID" "请在后台申请" "VIVO_APP_ID" #t "appId")
   ("CP ID" "请在后台申请" "" #f "cpId")
   ("CP KEY" "请在后台申请" "" #f "appSecret")
   ("是否输出日志" "true：输出；false：不输出" "IS_DEBUG" #t "")))
 (manifest
  ((application
    ((activity
      ((android:name "com.hutong.supersdk.wxapi.WXPayEntryActivity"))
      ((Revalue ((android:name "'PACKAGENAME'.wxapi.WXPayEntryActivity")))))
     (activity
      ((android:name "com.bbk.payment.tenpay.VivoQQPayResultActivity"))
      ((intent-filter
        ((data ((Revalue ((android:scheme "qwallet'PACKAGENAME'")))))))))))))
 (resource ())
 (attention ()))
