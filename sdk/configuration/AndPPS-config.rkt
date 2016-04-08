#lang racket
(require
  racket/date
  "sdk-module.rkt")

(provide info)

;; 
(define info
  (sdk ([name "PPS"]
        [id "AndPPS"]
        [channel "10035"]
        [version "3.8.0"]
        [inner-version "2.0"]
        [icon #t]
        [exit-dialog? #t]
        [unity-pack #t]
        [package-suffix ".pps"]
        
        [param
         (list
          (meta-data "APP ID" "应用ID" "APP_ID" "" #t))]
        
        [manifest '()]
        [resource '(([url "\\assets\\zConfig\\pps_packetid.properties"]
                     [name "导入渠道ID"]
                     [description "请在PPS后台申请渠道ID"]))]
        [attention '()])))



