;;;; -*- lisp -*-
;;;; cl-wiringpi2-examples.asd

(asdf:defsystem #:cl-wiringpi2-examples
  :description "Examples for cl-wiringpi2"
  :version "0.0.2"

  :author "Jacek Złydach <temporal.pl@gmail.com>"
  :license "MIT"

  :depends-on (#:cl-wiringpi2)

  :components
  ((:module "examples"
            :components ((:file "package")
                         (:file "blink")))))
