;;;; cl-wiringpi2.lisp

(in-package #:cl-wiringpi2)

(defun setup (&key (mode :wiring-pi) (terminate-on-error nil))
  "Initialize the Wiring Pi library.
`MODE' determines the type of initialization:
  - :WIRING-PI - use Wiring Pi pin numeration
  - :PHYS - use physical pin numeration
  - :GPIO, :BROADCOM - use Broadcom pin numeration
  - :SYS - use the /sys/class/gpio interface instead of accessing the hardware directly

Note that all modes except :SYS require the program to be run with superuser privileges.
Pin numeration under :SYS mode is the same as in :GPIO/:BROADCOM mode.

Set `TERMINATE-ON-ERROR' to `NIL' to restore the default behaviour of Wiring Pi 2 causing
the process to terminate if setup function fails."
  (unless terminate-on-error
    (setenv "WIRINGPI_CODES" "TRUE"))

  (ccase mode
    (:wiring-pi
     (wpi2-ffi:wiring-pi-setup))
    (:phys
     (wpi2-ffi:wiring-pi-setup-phys))
    ((:gpio :broadcom)
     (wpi2-ffi:wiring-pi-setup-gpio))
    (:sys
     (wpi2-ffi:wiring-pi-setup-sys))))
