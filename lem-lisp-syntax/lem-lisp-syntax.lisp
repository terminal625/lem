(uiop:define-package :lem-lisp-syntax
  (:use :cl)
  (:use-reexport
   :lem-lisp-syntax.indent
   :lem-lisp-syntax.syntax-table
   :lem-lisp-syntax.misc
   :lem-lisp-syntax.enclosing))