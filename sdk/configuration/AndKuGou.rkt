((name "酷狗音乐")
 (id "AndKuGou")
 (channel "AND0025")
 (version "5.3.3")
 (inner-version "2.0")
 (icon #t)
 (exit-dialog? #f)
 (unity-pack #t)
 (package-suffix ".kugou")
 (meta-data
  (("MERCHANT ID" "请在酷狗后台申请" "KG_MERCHANT_ID" #t "")
   ("APP ID" "请在酷狗后台申请" "KG_APP_ID" #t "")
   ("APP KEY" "请在酷狗后台申请" "KG_APP_KEY" #t "")
   ("PAY KEY" "请在酷狗后台申请" "" #f "key")
   ("GAME ID" "请在酷狗后台申请" "KG_GAME_ID" #t "")
   ("CODE" "注意：code内容里不要有换行" "KG_CODE" #t "")
   ("FULL_SCREEN" "true：全屏；false：取消全屏" "KG_FULL_SCREEN" #t "")
   ("RESTART ON SWITCH ACCOUNT"
    "切换账号是否重启：true，重启；false，不重启"
    "KG_RESTART_ON_SWITCH_ACCOUNT"
    #t
    "")
   ("HID PAY MODULE" "true：隐藏支付模块；false：不隐藏" "KG_HIDE_PAY_MODULE" #t "")
   ("HIDE GAME CENTER" "true：隐藏游戏中心；false：不隐藏" "KG_HIDE_GAME_CENTER" #t "")
   ("PUSH MESSAGE" "true：接受推送；false：不接受" "KG_PUSH_MESSAGE" #t "")
   ("SUPPORT FORCE UPDATE" "true：支持强制更新；false：不支持强制更新" "KG_SUPPORT_FORCE_UPDATE" #t "")))
 (manifest ())
 (resource ())
 (attention (((version "2.0") ("如果在初始化的时候把支付模块关闭，用户中心则不会显示消费记录，无法通过酷狗审查")))))
