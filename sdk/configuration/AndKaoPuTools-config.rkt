#lang racket
(require
  racket/date
  "sdk-module.rkt")

(provide info)

;; 
(define info
  (sdk ([name "靠谱助手"]
        [id "AndKaoPuTools"]
        [channel "10017"]
        [version "5.2"]
        [inner-version "2.0"]
        [icon #f]
        [exit-dialog? #t]
        [unity-pack #t]
        [package-suffix ".kaopu"]
        
        ;; huawei parameters
        [param
         ;;(meta-data key description local? isForClient?)
         (list (meta-data "APP ID" "靠谱助手APP ID" "KAOPU_APPID" "appId" #t)
               (meta-data "APP KEY" "靠谱助手APP KEY" "KAOPU_APPKEY" "appKey" #t)
               (meta-data "SECRET KEY" "靠谱助手SECRET KEY" "KAOPU_SECRETKEY" "secretKey" #t)
               (meta-data "APP VERSION" "游戏版本号，在靠谱后台申请" "KAOPU_APPVERSION" "" #t)
               (meta-data "APP NAME" "游戏名称" "APP_NAME" "" #t))]
        
        [manifest '()]
        [resource
         `([url "\\assets\\kaopu_game_cinfig.json"]
                   [name "配置文件"]
                   [description "请修改gameName为您的游戏名称；screenType为1是横屏，2是竖屏，fullScreen为true是全屏。其他参数不需要修改"])]
        [attention `([(version "2.0")
                    ("接入的时候，修改assets目录下的kaopu_game_config.json，填写游戏名称，横竖屏，全屏等信息。screentType=1是横屏，2是竖屏"
                     "靠谱助手初始化的时候，若弹窗提示：授权失败；请检查kaopu_game_config.json文件参数是否正确")])])))



