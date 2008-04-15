; Ripped off from steve yegge's blog...thanks to whoever wrote it
(defun gsub (search-string replace string &optional regexp-flag)
  "Like Ruby gsub."
  (with-temp-buffer
    (insert string)
    (goto-char (point-min))
    (let ((search-function (if regexp-flag 're-search-forward 'search-forward)))
      (while (funcall search-function search-string nil t)
        (replace-match replace))
      (buffer-string))))

