;;;; cloak.lisp

;; Copyright 2021 Alan Tseng
;; 
;; Licensed under the Apache License, Version 2.0 (the "License");
;; you may not use this file except in compliance with the License.
;; You may obtain a copy of the License at
;; 
;;     http://www.apache.org/licenses/LICENSE-2.0
;; 
;; Unless required by applicable law or agreed to in writing, software
;; distributed under the License is distributed on an "AS IS" BASIS,
;; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
;; See the License for the specific language governing permissions and
;; limitations under the License.

(in-package #:cloak)

;; Stores pointers and the Lisp objects they're associated with.
(defvar cloakroom
  (make-weak-hash-table
   :weakness :key
   :test #'equal))

(defun alloc-pointer ()
  "Returns a pointer that can be automatically garbage collected."
  (let* ((ptr (foreign-alloc :pointer))
	 (addr (pointer-address ptr)))
    (finalize ptr (lambda ()
		    (foreign-free (make-pointer addr))))))

(defun cloak (obj)
  "Returns a pointer associated with a given Lisp object."
  (let ((ptr (alloc-pointer)))
    (setf (gethash ptr cloakroom) obj)
    ptr))

(defun uncloak (ptr)
  "Returns the Lisp object corresponding to the given pointer."
  (multiple-value-bind (obj found)
      (gethash ptr cloakroom)
    (if (not found)
	(error "Couldn't uncloak the given pointer.")
	obj)))
