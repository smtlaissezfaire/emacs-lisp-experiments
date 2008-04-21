(defun read-file (filename)
  (with-temp-buffer
    (insert-file-contents filename)
    (goto-char (point-min))
    (buffer-string)))