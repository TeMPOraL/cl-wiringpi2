;;; package.lisp

(defpackage #:cl-wiringpi2-ffi
  (:nicknames #:wpi2-ffi)
  (:use #:cl
        #:alexandria
        #:cffi)

  (:export
   ;; constants
   #:+input+
   #:+output+
   #:+pwm-output+
   #:+gpio-clock+

   #:+low+
   #:+high+

   #:+pud-off+
   #:+pud-down+
   #:+pud-up+

   ;; functions
   #:wiring-pi-setup
   #:wiring-pi-setup-phys
   #:wiring-pi-setup-gpio
   #:wiring-pi-setup-sys

   #:pin-mode
   #:pull-up-dn-control

   #:digital-read
   #:digital-write
   #:pwm-write
   #:analog-read
   #:analog-write

   #:pi-board-rev
   #:wrapped-pi-board-id

   #:delay
   #:delay-microseconds

   #:millis
   #:micros))
