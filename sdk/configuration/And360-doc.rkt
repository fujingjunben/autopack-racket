#lang racket
(require racket/date
         "sdk-module.rkt"
         "sdk-release.rkt"
         "sdk-change-log.rkt"
         "360-config.rkt")


(define description "华为SDK更新，修改说明")
(define timestamp (date->string (current-date)))
;; when programming with huawei api, you should care about the following
(define release
  ;;(release name items)
  (release (property-sdk-name info)
           (content "2.0"
                    (list "如果华为点击悬浮窗崩溃，是因为缺少sdk中的android-support-v4，这个包含有华为自定义内容"
                          "切换账号的时候并不会弹出登陆界面，只有一个回调，返回的是切换账号失败的回调，请对该回调做处理，如跳转到游戏首页，然后重新初始化SuperSDK执行登陆。"
                          "包名必须以.huawei结尾"))))

(define change-log
  ;;(change-log name description sdk-version inner-version timestamp change fix add)
  (change-log (property-sdk-name info)
              description
              (list (log "1.6.3.53"
                         "2.0"
                         "2015-12-16"
                         (list "SuperSDK升级到1.1")
                         #f #f))))