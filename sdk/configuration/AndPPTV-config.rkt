#lang racket
(require
  racket/date
  "sdk-module.rkt")

(provide info)

;; 
(define info
  (sdk ([name "PPTV"]
        [id "AndPPTV"]
        [channel "10035"]
        [version "4.4"]
        [inner-version "2.0"]
        [icon #t]
        [exit-dialog? #t]
        [unity-pack #t]
        [package-suffix ".pptv"]
        
        [param
         (list
          (meta-data "Game Id" "游戏ID" "GAME_ID" "" #t)
          (meta-data "checkUpdate" "是否检测更新" "CHECKUPDATE" "" #t)
          (meta-data "debug" "是否开启调试模式，上线前请改成false" "PptvVasSDK_CCID" "" #f)
          (meta-data "Pay KEY" "支付KEY" "" "key" #f)
          (meta-data "友盟appKey" "友盟appKey" "UMENG_APPKEY" "" #f)
          (meta-data "是否使用友盟统计" "是否使用友盟统计" "useUmeng" "" #t))]
        
        [manifest '()]
        [resource '()]
        [attention '()])))



