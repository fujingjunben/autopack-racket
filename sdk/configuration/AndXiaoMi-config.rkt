#lang racket
(require
  racket/date
  "sdk-module.rkt")

(provide info)

;; 
(define info
  ;;(property sdk-name sdk-version inner-version icon support-splash? unity-pack?)
  (sdk ([name "小米"]
        [id "AndXiaoMi"]
        [channel "10043"]
        [version "4.3.90"]
        [inner-version "2.0"]
        [icon #f]
        [exit-dialog? #f]
        [unity-pack #t]
        [package-suffix ".mi"]
        
        [param
         (list
          (meta-data "APP ID" "请在小米后台申请" "XIAOMI_APP_ID" "appId" #t)
          (meta-data "APP KEY" "请在小米后台申请" "XIAOMI_APP_KEY" "" #t)
          (meta-data "APP SECRET" "请在小米后台申请" "" "appSecretKey" "#f"))]
        
        [manifest `()]
        [resource `()]
        [attention `()])))



