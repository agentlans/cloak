;;;; cloak.asd

(asdf:defsystem #:cloak
  :description "Foreign pointers for Lisp objects"
  :author "Alan Tseng"
  :license  "Apache License 2.0"
  :version "0.0.1"
  :serial t
  :depends-on ("cffi" "trivial-garbage")
  :components ((:file "package")
               (:file "cloak")))
