(defvar *rails-environment-file* "config/environment.rb")
(defvar *project-file* ".emproj")

;; Define rails-root if it's not around
(unless (functionp 'rails-root)
  ;; Taken from rinari, with a slight modification
  (defun rails-root
    (project-file *rails-environment-file*)))

(defun project-root nil
  (or (rails-root)
      (project-file *project-file*)))

(defun project-file (file &optional dir)
  (or dir (setq dir default-directory))
  (if (file-exists-p (concat dir file))
      dir
    (if (equal dir  "/")
        nil
      (project-file file (expand-file-name (concat dir "../"))))))

(project-root)
