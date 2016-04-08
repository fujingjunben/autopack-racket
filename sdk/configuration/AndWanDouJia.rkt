((name "豌豆荚")
 (id "AndWanDouJia")
 (channel "AND0042")
 (version "4.0.3")
 (inner-version "2.0")
 (icon #f)
 (exit-dialog? #f)
 (unity-pack #t)
 (package-suffix ".wdj")
 (meta-data
  (("APP KEY" "请在豌豆荚后台申请" "APP_ID" #t "wdjAppKeyId")
   ("SECRET ID" "请在豌豆荚后台申请" "APP_KEY" #t "")))
 (manifest
  ((application
    ((activity
      ((android:name "com.wandoujia.oakenshield.activity.OakenshieldActivity"))
      ((intent-filter
        ((data
         ((Revalue ((android:scheme "Wandoujia-PaySdk-'APP_ID'")))))))))))))
 (resource ())
 (attention ()))
