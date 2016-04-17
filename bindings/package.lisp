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

   #:+alt-0+
   #:+alt-1+
   #:+alt-2+
   #:+alt-3+
   #:+alt-4+
   #:+alt-5+

   #:+low+
   #:+high+

   #:+pud-off+
   #:+pud-down+
   #:+pud-up+

   #:+pi-model-a+
   #:+pi-model-b+
   #:+pi-model-ap+
   #:+pi-model-bp+
   #:+pi-model-2+
   #:+pi-alpha+
   #:+pi-model-cm+
   #:+pi-model-07+
   #:+pi-model-3+
   #:+pi-model-zero+

   #:+pi-maker-sony+
   #:+pi-maker-egoman+
   #:+pi-maker-mbest+
   #:+pi-maker-unknown+

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

   #:get-alt

   #:delay
   #:delay-microseconds

   #:millis
   #:micros))
