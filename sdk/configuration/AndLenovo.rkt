((name "联想应用商店")
 (id "AndLenovo")
 (channel "AND0027")
 (version "2.4.2.1")
 (inner-version "2.0")
 (icon #t)
 (exit-dialog? #t)
 (unity-pack #t)
 (package-suffix ".lenovo")
 (meta-data
  (("APP ID" "lenovo open appid" "lenovo.open.appid" #f "realm")
   ("APP KEY" "支付密钥" "LENOVO_APPKEY" #t "pub_key")))
 (manifest
  ((application
    ((receiver
      ((android:name "com.lenovo.lsf.gamesdk.receiver.GameSdkReceiver"))
      ((intent-filter ((action ((Revalue ((android:name "'APP_ID'")))))))))
     (receiver
      ((android:name "com.lenovo.lsf.gamesdk.receiver.GameSdkReceiver"))
      ((intent-filter
        ((category ((Revalue ((android:name "'PACKAGENAME'")))))))))
     (receiver
      ((android:name
        "com.lenovo.lsf.gamesdk.receiver.GameSdkAndroidLReceiver"))
      ((intent-filter
        ((category ((Revalue ((android:name "'PACKAGENAME'")))))))))))))
 (resource ())
 (attention ()))
