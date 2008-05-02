
(load "ruby")

(defun ruby-snippets-rfd ()
  (interactive)
  (insert "require File.dirname(__FILE__) + \"/\"")
  (backward-char))

(defun ruby-snippets-debug ()
  (interactive)
  (insert "require 'rubygems'; require 'ruby-debug'; debugger"))


;; Switch to test ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (defun ruby-snippets-switch-to-test ()
;;   "Switch from a rails file in app to the corresponding Test::Unit test"
;;   (interactive)
;;   (let (filename buffer-file-name)
;;     (debug)
;;     (cond ((search filename "controllers")
;;            (switch-to-test :controller, filename))
;;           ((search filename "models")
;;            (switch-to-test :model, filename))
;;           ((message "Invalid file type!")))))

;; (defun switch-to-test (type, filename)
;;   (find-file (sub-test-filename type filename)))

;; (defun sub-test-filename (type, filename)
;;   (let (modified-filename (concat (chop_off_rb filename) "_test.rb"))
;;     (case type
;;       (:model
;;        (gsub "app/models" "test/unit" modified-filename))
;;       (:controller
;;        (gsub "app/controllers" "test/functional" modified-filename)))))

;; (defun chop_off_rb (filename)
;;   (gsub ".rb" "" filename))

;; (ruby-snippets-switch-to-test)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


