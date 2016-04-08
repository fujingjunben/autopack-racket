#lang racket
(require "sdk-module.rkt")

;; when programming with huawei api, you should care about the following
(define huawei-release
  ;;(release name items)
  (release name
           (version "2.0"
           (list "如果华为点击悬浮窗崩溃，是因为缺少sdk中的android-support-v4，这个包含有华为自定义内容"
                 "切换账号的时候并不会弹出登陆界面，只有一个回调，返回的是切换账号失败的回调，请对该回调做处理，如跳转到游戏首页，然后重新初始化SuperSDK执行登陆。"
                 "包名必须以.huawei结尾"))))

(define huawei-change-log
  ;;(change-log name description sdk-version inner-version timestamp change fix add)
  (change-log name
              description
              (list (log "1.6.3.53"
                              "2.0"
                              "2015-12-16"
                              (list "SuperSDK升级到1.1")
                              #f #f))))