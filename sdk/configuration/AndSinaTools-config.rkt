#lang racket
(require
  racket/date
  "sdk-module.rkt")

(provide info)

;; 
(define info
  ;;(property sdk-name sdk-version inner-version icon support-splash? unity-pack?)
  (sdk ([name "新浪助手"]
        [id "AndSinaTools"]
        [channel "10039"]
        [version "1.0.4"]
        [inner-version "2.0"]
        [icon #t]
        [exit-dialog? #f]
        [unity-pack #t]
        [package-suffix ".sguo"]
        
        [param
         (list
          (meta-data "APP ID" "应用ID，在后台申请" "CYJH_APPID" "appid" #f)
          (meta-data "APP KEY" "厂商ID，在后台申请" "CYJH_APPKEY" "" #f)
          (meta-data "APP SECRET" "应用KEY，在后台申请" "CYJH_SECRETKEY" "appsecret" #f)
          (meta-data "VERSION" "CP自行定义并通知松果运维" "CYJH_APPVERSION" "" #f))]
        
        [manifest
         `()]
        [resource
         (list
          `([url "\\assets\\sguo_game_config.json"]
            [name "配置文件"]
            [description "请修改gameName为您的游戏名称；screenType为1是横屏，2是竖屏，fullScreen为true是全屏。其他参数不需要修改"]))]
        [attention `()])))



