


(defun run-ack (search-string &optional ((directory ".")))
  (interactive)
  (shell-command (concat "ack " search-string " " directory)))


