;;;; package.lisp

(defpackage #:cl-wiringpi2
  (:nicknames #:wpi2)
  (:use #:cl)

  (:import-from #:wpi2-ffi
                #:+low+
                #:+high+)

  (:export #:setup
           #:pin-mode
           #:set-pull-resistor-mode
           #:digital-write
           #:pwm-write
           #:digital-read
           #:analog-read
           #:analog-write
           #:pi-board-revision
           #:pi-board-info
           #:pi-board-info*
           #:milliseconds
           #:microseconds
           #:delay
           #:delay-microseconds

           ;; reexports from wpi2-ffi
           #:+low+
           #:+high+))
