#lang racket
(require
  racket/date
  "sdk-module.rkt")

(provide info)

;; 
(define info
  (sdk ([name "木蚂蚁"]
        [id "AndMuMaYi"]
        [channel "10031"]
        [version "3.1"]
        [inner-version "2.0"]
        [icon #t]
        [exit-dialog? #t]
        [unity-pack #t]
        [package-suffix ".mumayi"]
        
        [param
         (list (meta-data "APP KEY" "应用key，请在木蚂蚁后台申请" "APP_KEY" "appKey"  #t)
               (meta-data "APP NAME" "游戏名称" "APP_NAME" "" #t))]
        
        [manifest
         `()]
        [resource '()]
        [attention `()])))



