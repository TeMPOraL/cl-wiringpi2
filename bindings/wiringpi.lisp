;;; wiringpi.lisp - bindings for wiringPi.h

(in-package #:cl-wiringpi2-ffi)

(define-foreign-library lib-wiringpi
  (:unix "libwiringPi.so")
  (t (:default "libwiringPi")))

#-testing-cffi(use-foreign-library lib-wiringpi)

;;; wiringPi modes
(define-constant +wpi-mode-pins+ 0)
(define-constant +wpi-mode-gpio+ 1)
(define-constant +wpi-mode-gpio-sys+ 2)
(define-constant +wpi-mode-phys+ 3)
(define-constant +wpi-mode-piface+ 4)
(define-constant +wpi-mode-uninitialised+ -1)

;;; Pin modes
(define-constant +input+ 0)
(define-constant +output+ 1)
(define-constant +pwm-output+ 2)
(define-constant +gpio-clock+ 3)
(define-constant +soft-pwm-output+ 4)
(define-constant +soft-tone-output+ 5)
(define-constant +pwm-tone-output+ 6)

(define-constant +low+ 0)
(define-constant +high+ 1)

;;; Pull up/down/none
(define-constant +pud-off+ 0)
(define-constant +pud-down+ 1)
(define-constant +pud-up+ 2)

;;; PWM
(define-constant +pwm-mode-ms+ 0)
(define-constant +pwm-mode-bal+ 1)

;;; Interrupt levels
(define-constant +int-edge-setup+ 0)
(define-constant +int-edge-falling+ 1)
(define-constant +int-edge-rising+ 2)
(define-constant +int-edge-both+ 3)

;;; Pi model types and version numbers
;;; Intended for the GPIO program
;;; Use at your own risk.
(define-constant +pi-model-a+ 0)
(define-constant +pi-model-b+ 1)
(define-constant +pi-model-ap+ 2)
(define-constant +pi-model-bp+ 3)
(define-constant +pi-model-2+ 4)
(define-constant +pi-alpha+ 5)
(define-constant +pi-model-cm+ 6)
(define-constant +pi-model-07+ 7)
(define-constant +pi-model-3+ 8)
(define-constant +pi-model-zero+ 9)

(define-constant +pi-version-1+ 0)
(define-constant +pi-version-1-1+ 1)
(define-constant +pi-version-1-2+ 2)
(define-constant +pi-version-2+ 3)

(define-constant +pi-maker-sony+ 0)
(define-constant +pi-maker-egoman+ 1)
(define-constant +pi-maker-mbest+ 2)
(define-constant +pi-maker-unknown+ 3)

(defcvar ("piModelNames" +pi-model-names+ :read-only t) (:pointer :string))
(defcvar ("piRevisionNames" +pi-revision-names+ :read-only t) (:pointer :string))
(defcvar ("piMakerNames" +pi-maker-names+ :read-only t) (:pointer :string))
(defcvar ("piMemorySize" +pi-memory-size+ :read-only t) (:pointer :int))

#|

//	Intended for the GPIO program Use at your own risk.

// Threads

#define	PI_THREAD(X)	void *X (void *dummy)
|#

;;; Failure modes

(define-constant +wpi-fatal+ t)
(define-constant +wpi-almost+ nil)

;; Original comment from wiringPi.h:

;; // wiringPiNodeStruct:
;; //	This describes additional device nodes in the extended wiringPi
;; //	2.0 scheme of things.
;; //	It's a simple linked list for now, but will hopefully migrate to 
;; //	a binary tree for efficiency reasons - but then again, the chances
;; //	of more than 1 or 2 devices being added are fairly slim, so who
;; //	knows....
(defcstruct wiring-pi-node-struct
  (pin-base :int)
  (pin-max :int)

  (fd :int)
  (data0 :unsigned-int)
  (data1 :unsigned-int)
  (data2 :unsigned-int)
  (data3 :unsigned-int)

  ;; function pointers
  ;;   void   (*pinMode)         (struct wiringPiNodeStruct *node, int pin, int mode) ;
  (fn-pin-mode :pointer)
  
  ;; void   (*pullUpDnControl) (struct wiringPiNodeStruct *node, int pin, int mode) ;
  (fn-pull-up-dn-control :pointer)
  
  ;; int    (*digitalRead)     (struct wiringPiNodeStruct *node, int pin) ;
  (fn-digital-read :pointer)
  
  ;; void   (*digitalWrite)    (struct wiringPiNodeStruct *node, int pin, int value) ;
  (fn-digital-write :pointer)
  
  ;; void   (*pwmWrite)        (struct wiringPiNodeStruct *node, int pin, int value) ;
  (fn-pwm-write :pointer)
  
  ;; int    (*analogRead)      (struct wiringPiNodeStruct *node, int pin) ;
  (fn-analog-read :pointer)
  
  ;; void   (*analogWrite)     (struct wiringPiNodeStruct *node, int pin, int value) ;
  (fn-analog-write :pointer)

  (wiring-pi-nodes :pointer)            ; pointer to next element of this structure; forms a linked list
  )

(defcvar ("wiringPiNodes" wiring-pi-nodes) (:pointer (:struct wiring-pi-node-struct)))

;;; Function prototypes

#|
Left behind for now because translating variable argument lists to CFFI seems to be pretty tricky.

extern int wiringPiFailure (int fatal, const char *message, ...) ;

|#

;; Core wiringPi functions
(defcfun ("wiringPiSetup" wiring-pi-setup) :int)
(defcfun ("wiringPiSetupSys" wiring-pi-setup-sys) :int)
(defcfun ("wiringPiSetupGpio" wiring-pi-setup-gpio) :int)
(defcfun ("wiringPiSetupPhys" wiring-pi-setup-phys) :int)

(defcfun ("pinModeAlt" pin-mode-alt) :void (pin :int) (mode :int))
(defcfun ("pinMode" pin-mode) :void  (pin :int) (mode :int))
(defcfun ("pullUpDnControl" pull-up-dn-control) :void  (pin :int) (pud :int))

(defcfun ("digitalRead" digital-read) :int  (pin :int))
(defcfun ("digitalWrite" digital-write) :void  (pin :int) (value :int))
(defcfun ("pwmWrite" pwm-write) :void  (pin :int) (value :int))
(defcfun ("analogRead" analog-read) :int  (pin :int))
(defcfun ("analogWrite" analog-write) :int  (pin :int) (value :int))

;; PiFace specifics (Deprecatd)
(defcfun ("wiringPiSetupPiFace" wiring-pi-setup-pi-face) :int)
(defcfun ("wiringPiSetupPiFaceForGpioProg" wiring-pi-setup-pi-face) :int) ;; // Don't use this - for gpio program only

;; On-Board Raspberry Pi hardware specific stuff
(defcfun ("piBoardRev" pi-board-rev) :int)
(defcfun ("piBoardId" pi-board-id) :void
  (model (:pointer :int))
  (rev (:pointer :int))
  (mem (:pointer :int))
  (maker (:pointer :int))
  (overvolted (:pointer :int)))

(defun wrapped-pi-board-id ()
  (with-foreign-objects ((model :int) (rev :int) (mem :int) (maker :int) (overvolted :int))
    (pi-board-id model rev mem maker overvolted)
    (list (mem-ref model :int)
          (mem-ref rev :int)
          (mem-ref mem :int)
          (mem-ref maker :int)
          (mem-ref overvolted :int))))

(defcfun ("wpiPinToGpio" wpi-pin-to-gpio) :int (wpi-pin :int))
(defcfun ("physPinToGpio" phys-pin-to-gpio) :int (phys-pin :int))
(defcfun ("setPadDrive" set-pad-drive) :void (group :int) (value :int))
(defcfun ("getAlt" get-alt) :int (pin :int))

(defcfun ("pwmToneWrite" pwm-town-write) :void (pin :int) (freq :int))
(defcfun ("digitalWriteByte" digital-write-byte) :void (value :int))
(defcfun ("digitalReadByte" digital-read-byte) :unsigned-int)

(defcfun ("pwmSetMode" pwm-set-mode) :void (mode :int))
(defcfun ("pwmSetRange" pwm-set-range) :void (range :unsigned-int))
(defcfun ("pwmSetClock" pwm-set-clock) :void (divisor :int))
(defcfun ("gpioClockSet" gpio-clock-set) :void (pin :int) (freq :int))

(defcfun ("waitForInterrupt" wait-for-interrupt) :int (pin :int) (ms :int))
(defcfun ("wiringPiISR" wiring-pi-isr-interal) :int (pin :int) (mode :int) (function :pointer))

;; Interrupts
;; (Also Pi hardware specific)

#|

// On-Board Raspberry Pi hardware specific stuff

// Interrupts
//	(Also Pi hardware specific)

// Threads

extern int  piThreadCreate      (void *(*fn)(void *)) ;
extern void piLock              (int key) ;
extern void piUnlock            (int key) ;

// Schedulling priority

extern int piHiPri (const int pri) ;

|#

;; Extras from Arduino land
(defcfun ("delay" delay) :void (how-long :unsigned-int))
(defcfun ("delayMicroseconds" delay-microseconds) :void (how-long :unsigned-int))

(defcfun ("millis" millis) :unsigned-int)
(defcfun ("micros" micros) :unsigned-int)
