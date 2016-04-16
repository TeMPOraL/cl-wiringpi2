(in-package #:cl-wiringpi2)

(defun setenv (variable value &optional (overwritep t))
  (declare (ignorable variable value overwritep))
  (or #+ccl (ccl::setenv variable value overwritep)
      #+sbcl (sb-posix:putenv (concatenate 'string variable value))
      ;; TODO more, esp. ECL.
      (warn "This version of `SETENV' does not support your Lisp implementation.")))
