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
      (ccase mode
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
  (let ((mode-id (ccase mode
                   (:INPUT wpi2-ffi:+input+)
                   (:OUTPUT wpi2-ffi:+output+)
                   (:PWM-OUTPUT wpi2-ffi:+pwm-output+)
                   (:GPIO-CLOCK wpi2-ffi:+gpio-clock+))))
    (wpi2-ffi:pin-mode pin mode-id)))

(defun set-pull-resistor-mode (pin mode)
  "Set the mode of pull-up / pull-down resistors on the `PIN'.
Available modes are:
  - :OFF - no pull up / down
  - :PULL-UP - pull up (to 3.3V)
  - :PULL-DOWN - pull down (pull to ground)

`PIN' should be set to input."
  (let ((pud (ccase mode
               (:OFF wpi2-ffi:+pud-off+)
               (:PULL-UP wpi2-ffi:+pud-up+)
               (:PULL-DOWN wpi2-ffi:+pud-down+))))
   (wpi2-ffi:pull-up-dn-control pin pud)))

(defun digital-write (pin value)
  "Write `VALUE' to `PIN'.
Use constants `+LOW+' and `+HIGH+' for `VALUE'."
  (wpi2-ffi:digital-write pin value))

(defun pwm-write (pin value)
  "Write `VALUE' to PWM register for the given `PIN'.
The range for `VALUE' is 0-1024 for Raspberry Pi's on-board PWM pin (pin 1, BMC_GPIO 18, physical: 12)."
  (wpi2-ffi:pwm-write pin value))

(defun digital-read (pin)
  "Read the state of `PIN'.
Returns numeric value of the pin state; compare with constants `+LOW+' and `+HIGH+'."
  (wpi2-ffi:digital-read pin))

(defun analog-read (pin)
  "Returns the value on the analog input `PIN'.
Note, apparently there are no analog pins on the Raspberry Pi itself; read will return a dummy value there."
  (wpi2-ffi:analog-read pin))

(defun analog-write (pin value)
  "Writes the given `VALUE' to the supplied analog `PIN'.
Note, apparently there are no analog pins on the Raspberry Pi itself - the write will be non-effective there."
  (wpi2-ffi:analog-write pin value))

(defun pi-board-revision ()
  "Returns the board version of the Raspberry Pi. It will be either 1 or 2.

Revision 1 means early Model A and B's.
Revision 2 is everything else - B, B+, CM, Pi 2, Pi Zero, Pi3.
Some of the pins in Broadcom numeration change their numbers depending on the board revision."
  (wpi2-ffi:pi-board-rev))

(defun pi-board-info ()
  "Returns the hardware information of Raspberry Pi board."
  (wpi2-ffi:wrapped-pi-board-id))

(defun milliseconds ()
  "Returns the number of milliseconds since the call to setup function.
Note that the number will wrap around after around 49 days."
  (wpi2-ffi:millis))

(defun microseconds ()
  "Returns the number of microseconds since the call to setup function.
Note that the number will wrap around after around 71 minutes."
  (wpi2-ffi:micros))

(defun delay (milliseconds)
  "Pause the execution for at least `MILLISECONDS' milliseconds.
Maximum delay is approximately 49 days."
  (wpi2-ffi:delay milliseconds))

(defun delay-microseconds (microseconds)
  "Pause the execution for at least `MICROSECONDS' microseconds.
Maximum delay is approximately 71 minutes."
  (wpi2-ffi:delay-microseconds microseconds))
