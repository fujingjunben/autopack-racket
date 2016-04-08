((name "靠谱助手")
 (id "AndKaoPuTools")
 (channel "AND0017")
 (version "5.2")
 (inner-version "2.0")
 (icon #f)
 (exit-dialog? #t)
 (unity-pack #t)
 (package-suffix ".kaopu")
 (meta-data
  (("APP ID" "靠谱助手APP ID" "KAOPU_APPID" #f "appId")
   ("APP KEY" "靠谱助手APP KEY" "KAOPU_APPKEY" #f "appKey")
   ("SECRET KEY" "靠谱助手SECRET KEY" "KAOPU_SECRETKEY" #f "secretKey")
   ("APP VERSION" "游戏版本号，在靠谱后台申请" "KAOPU_APPVERSION" #f "")
   ("APP NAME" "游戏名称" "APP_NAME" #f "")))
 (manifest ())
 (resource
  ((url "\\assets\\kaopu_game_cinfig.json")
   (name "配置文件")
   (description
    "请修改gameName为您的游戏名称；screenType为1是横屏，2是竖屏，fullScreen为true是全屏。其他参数不需要修改")))
 (attention
  (((version "2.0")
    ("接入的时候，修改assets目录下的kaopu_game_config.json，填写游戏名称，横竖屏，全屏等信息。screentType=1是横屏，2是竖屏"
     "靠谱助手初始化的时候，若弹窗提示：授权失败；请检查kaopu_game_config.json文件参数是否正确")))))
