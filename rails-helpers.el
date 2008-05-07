(defvar *rails-environment-file* "config/environment.rb")

;; Define rails-root if it's not around
(unless (functionp 'rails-root)
  ;; Taken from rinari, with a slight modification
  (defun rails-root (&optional dir)
    (or dir (setq dir default-directory))
    (if (file-exists-p (concat dir *rails-environment-file*))
        dir
      (if (equal dir  "/")
          nil
        (rails-root (expand-file-name (concat dir "../")))))))

