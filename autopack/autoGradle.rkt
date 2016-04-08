#lang racket
(require "autoPack-150.rkt")
(provide (all-defined-out))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PATH Variable
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; gradle path
(define gradle-cli (find-executable-path "gradle"))

;; java path
(define java-exe (find-executable-path "java.exe"))

;; supersdk project directory
(define prjDir "e:/git/supersdk-client/Android/SuperSDK-Client/")

;; auto build channel
(define channel-list '("And360" "And37Wan" "And4399"))


(define (gradle args)
  (system (format "~a ~a" (path->string gradle-cli) args)))

(define (autoGradle channel gradle)
  (current-directory (string-append prjDir channel))
  (gradle "build")
  (gradle "copyJPush")
  (->apk channel)
  (autopack channel))