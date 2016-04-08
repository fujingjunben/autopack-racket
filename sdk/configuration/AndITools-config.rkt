#lang racket
(require
  racket/date
  "sdk-module.rkt"
  "sdk-release.rkt"
  "sdk-change-log.rkt")

(provide itools-property
         itools-param
         itools-release
         itools-change-log)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @name
;; @sdk-version
;; @inner-version
;; @description
;; @timestamp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define name "itools")
(define sdk-version "1.1.4")
(define inner-version "2.0")
(define description "ITOOLS SDK更新，修改说明")
(define timestamp (date->string (current-date)))

;; property, release and changelog
(define itools-property
  ;;(property sdk-name sdk-version inner-version icon support-splash? unity-pack?)
  (property name sdk-version inner-version #f #f #t))

;; huawei parameters
(define itools-param
  ;;(meta-data key description local?)
  (list (meta-data "APP_ID" "itools APP ID" #f)
        (meta-data "APP KEY" "itools APP KEY" #f)))

;; when programming with huawei api, you should care about the following
(define itools-release
  ;;(release name items)
  (release name
           (list "itools启动奔溃，缺少android-support-v4.jar")))

(define itools-change-log
  ;;(change-log name description sdk-version inner-version timestamp change fix add)
  (change-log name
              description
              (list (log-item "1.1.4"
                              "2.0"
                              "2015-12-16"
                              (list "SuperSDK升级到1.1")
                              #f #f))))
