((name "琵琶（游狐支付）")
 (id "AndYouHuPay")
 (channel "AND0047")
 (version "2.6")
 (inner-version "2.0")
 (icon #t)
 (exit-dialog? #t)
 (unity-pack #t)
 (package-suffix ".erhu")
 (meta-data
  (("APP ID" "应用ID" "appId" #t "appId")
   ("merchantId" "商家ID" "merchantId" #t "merchantId")
   ("merchantAppId" "游戏ID" "merchantAppId" #t "merchantAppId")
   ("privateKey" "私钥" "privateKey" #t "keys")))
 (manifest
  ((application
    ((service
      ((android:name "com.tencent.android.tpush.rpc.XGRemoteService"))
      ((intent-filter
        ((action
          ((Revalue ((android:name "'PACKAGENAME'.PUSH_ACTION")))))))))))))
 (resource ())
 (attention ()))
