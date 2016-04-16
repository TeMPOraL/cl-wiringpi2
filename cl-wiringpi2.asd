;;;; cl-wiringpi2.asd

(asdf:defsystem #:cl-wiringpi2
  :description "CFFI bindings to WiringPi 2."
  :author "Jacek Złydach <temporal.pl@gmail.com>"
  :license "MIT"
  :depends-on (#:alexandria
               #:cffi)
  :serial t
  :components ((:module "bindings"
                        :components ((:file "package")
                                     (:file "wiringpi")))
               (:file "package")
               (:file "cl-wiringpi2")))
