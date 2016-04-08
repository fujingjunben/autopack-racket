((name "应用宝")
 (id "AndYingYongBao")
 (channel "AND0050")
 (version "midas1.5+msdk2.5.4")
 (inner-version "2.0")
 (icon #f)
 (exit-dialog? #f)
 (unity-pack #t)
 (package-suffix ".yyb")
 (meta-data
  (("QQ APP ID" "QQ APP ID" "qqAppId" #t "qqAppId")
   ("QQ APP KEY" "QQ APP KEY" "qqAppKey" #t "qqAppKey")
   ("微信 APP ID" "微信 APP ID" "wxAppId" #t "wxAppId")
   ("微信 APP KEY" "微信 APP KEY" "wxAppKey" #t "wxAppKey")
   ("offer Id" "支付 ID" "offerId" #t "")
   ("msdk key" "MSDK KEY" "AppKey" #t "")
   ("midas key" "沙箱 KEY或者现网 KEY" "" #f "midasAppKey")
   ("正式模式还是测试模式" "release为正式模式；debug为测试模式" "mode" #t "")
   ("是否输出日志" "true：输出日志；false：不输出日志" "isDebug" #t "")
   ("是否定额支付" "支付界面的充值金额是否可以修改，true：可以修改；false：不可以修改" "isFixedPay" #t "")
   ("应用宝虚拟货币兑换率" "请填数字，如10或者100" "" #f "balanceExchangeRate")))
 (manifest
  ((application
    ((activity
      ((android:name "com.tencent.tauth.AuthActivity")
       (android:launchMode= "singleTask")
       (android:noHistory "true"))
      ((intent-filter
        ((data ((Revalue ((android:scheme "tencent'qqAppId'")))))))))
     (activity
      ((android:excludeFromRecents "true")
       (android:exported "true")
       (android:label "WXEntryActivity")
       (android:launchMode "singleTop"))
      ((Revalue ((android:name "'PACKAGENAME'.WXEntryActivity")))))
     (activity
      ((android:excludeFromRecents "true")
       (android:exported "true")
       (android:label "WXEntryActivity")
       (android:launchMode "singleTop"))
      ((Revalue ((android:tasdkAffinity "'PACKAGENAME'.diff")))))
     (activity
      ((android:excludeFromRecents "true")
       (android:exported "true")
       (android:label "WXEntryActivity")
       (android:launchMode "singleTop"))
      ((intent-filter ((data ((Revalue ((android:scheme "'wxAppId'")))))))))
     (activity
      ((android:name "com.tencent.midas.qq.APMidasQQWalletActivity"))
      ((intent-filter
        ((data ((Revalue ((android:scheme "qwallet'qqAppId'")))))))))))))
 (resource
  (((url "\\assets\\msdkconfig.ini")
    (name "配置文件")
    (description "请将文件assets\\msdkconfig.ini复制到桌面，修改后导入。请在文件中切换正式环境和测试环境"))))
 (attention ()))
