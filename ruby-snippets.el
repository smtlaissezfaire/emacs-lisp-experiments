(defun ruby-snippet-rfd ()
  (interactive)
  (insert "require File.dirname(__FILE__) + \"/\"")
  (backward-char))
