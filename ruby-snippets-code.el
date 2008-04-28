
(defun ruby-snippets-rfd ()
  (interactive)
  (insert "require File.dirname(__FILE__) + \"/\"")
  (backward-char))

(defun ruby-snippets-debug ()
  (interactive)
  (insert "require 'rubygems'; require 'ruby-debug'; debugger"))


  
