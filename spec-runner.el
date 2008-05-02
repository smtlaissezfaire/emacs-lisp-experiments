
(defun run-specs ()
  (interactive)
  (shell-command (concat "~/src/svn/flavorpill/flavorpill_com/trunk/script/spec" " "
                         "--drb" " "
                         "--color" " "
                         buffer-file-name)))
