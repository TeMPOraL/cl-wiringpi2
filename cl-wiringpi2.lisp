;;;; cl-wiringpi2.lisp

(in-package #:cl-wiringpi2)

(defvar *setup-mode* nil "Mode in which Wiring Pi was initialized.")

(defun initializedp ()
  "Check if the WiringPi library was initialized."
  *setup-mode*)

(defun in-sys-mode ()
  "Check if initialization was done in :SYS mode."
  (eql *setup-mode* :SYS))

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

  (prog1
      (ecase mode
        (:wiring-pi
         (wpi2-ffi:wiring-pi-setup))
        (:phys
         (wpi2-ffi:wiring-pi-setup-phys))
        ((:gpio :broadcom)
         (wpi2-ffi:wiring-pi-setup-gpio))
        (:sys
         (wpi2-ffi:wiring-pi-setup-sys)))
    (setf *setup-mode* mode)))

(defun pin-mode (pin mode)
  "Try to set `PIN' to `MODE'.
Available modes are:
  - :INPUT
  - :OUTPUT
  - :PWM-OUTPUT
  - :GPIO-CLOCK

This function has no effect in :SYS mode."
  (let ((mode-id (ecase mode
                   (:INPUT wpi2-ffi:+input+)
                   (:OUTPUT wpi2-ffi:+output+)
                   (:PWM-OUTPUT wpi2-ffi:+pwm-output+)
                   (:GPIO-CLOCK wpi2-ffi:+gpio-clock+))))
    (wpi2-ffi:pin-mode pin mode-id)))
