;;; package.lisp

(defpackage #:cl-wiringpi2-ffi
  (:nicknames #:wpi2-ffi)
  (:use #:cl
        #:alexandria
        #:cffi)

  (:export #:wiring-pi-setup
           #:wiring-pi-setup-phys
           #:wiring-pi-setup-gpio
           #:wiring-pi-setup-sys))
