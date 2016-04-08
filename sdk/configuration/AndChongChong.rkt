((name "虫虫助手")
 (id "AndChongChong")
 (channel "AND0009")
 (version "1.30")
 (inner-version "2.0")
 (icon #t)
 (exit-dialog? #f)
 (unity-pack #t)
 (package-suffix ".chongchong")
 (meta-data
  (("APP ID" "应用ID" "app_id" #f "gameId")
   ("developer key" "请在后台获取" "developer_key" #f "")
   ("签名密钥" "请在后台获取" "" #f "appSecret")))
 (manifest
  ((application ((receiver ((android:name "com.hutong.libsupersdk.sdk.LoginOutBroadcastReceiver"))
                  ((intent-filter 
                  ((data ((Revalue ((android:scheme "'app_id'")))))))))))))
 (resource ())
 (attention ()))
