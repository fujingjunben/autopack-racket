#lang racket
(require
  racket/date
  "sdk-module.rkt")

(provide info)

;; 
(define info
  ;;(property sdk-name sdk-version inner-version icon support-splash? unity-pack?)
  (sdk ([name "UC"]
        [id "AndUC"]
        [channel "10040"]
        [version "3.5.3.1"]
        [inner-version "2.0"]
        [icon #t]
        [exit-dialog? #f]
        [unity-pack #t]
        [package-suffix ".uc"]
        
        [param
         (list
          (meta-data "CP ID" "厂商 ID，在后台申请" "ANDUCSDK_CPID" "" #t)
          (meta-data "API KEY" "请在UC后台申请" "" "apiKey" #f)
          (meta-data "SERVER ID" "服务器 ID" "ANDUCSDK_SERVERID" "" #t)
          (meta-data "登录界面样式" "USE_WIDGET：简版登录界面；USE_STANDARD：标准版登录界面" "ANDUCSDK_LOGINFACETYPE" "" #t)
          (meta-data "登录窗口标题" "请填写游戏名称" "ANDUCSDK_ACCOUNTTITLE" "" #t)
          (meta-data "GAME ID" "游戏 ID" "ANDUCSDK_GAMEID" "gameId" #t)
          (meta-data "支付回调地址" "支付回调地址" "ANDUCSDK_PAYNOTIFYURL" "" #t)
          (meta-data "调试环境" "是否打开调试环境。true：调试环境；false：生产环境" "ANDUCSDK_DEBUGMODE" "" #t))]
        
        [manifest
         `()]
        [resource
         `()]
        [attention `()])))



