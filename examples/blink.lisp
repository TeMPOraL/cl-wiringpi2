(in-package #:wpi2-examples)

(defun blink (&optional (n 10))
  "Initialize the Wiring Pi library and blink a LED connected to pin 0 `N' times."
  (setup)
  (pin-mode 0 :OUTPUT)
  (dotimes (dummy n)
    (digital-write 0 :HIGH)
    (delay 500)
    (digital-write 0 :LOW)
    (delay 500)))
