;;;; package.lisp

(defpackage :cloak
  (:use :common-lisp :cffi :trivial-garbage)
  (:export
   :cloak
   :uncloak))
