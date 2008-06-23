;;;; Find in project, Interactive
;; Plan: 
;;
;; - Set project root
;; - Use an interactive fuzzy-match against a string
;; - Make it interactive, so that files can be cycled through
;;
;; Dependencies:
;;  iswitchb

(add-to-list 'load-path ".")
(load "cl.el")
(load "utils")
(load "rails-helpers")

(defun interactive-find-in-project nil
  "If we are in a rails project, use the interactive lookup - otherwise,
use the regular old find-file (doesn't do this, yet)"
  ; taken from iswitch-b documentation
  (defun interactive-find-in-project-prompt (prompt choices)
    "Use iswitch as a completing-read replacement to choose from
choices.  PROMPT is a string to prompt with.  CHOICES is a list of
strings to choose from."
    (let ((iswitchb-make-buflist-hook
           (lambda ()
             (setq iswitchb-temp-buflist choices))))
      (iswitchb-read-buffer prompt)))
  (interactive)
  (cond ((project-root)
         (lookup-and-switch-to 
          (interactive-find-in-project-prompt "find-in-project: "
                                              (firsts (find-files (project-root))))))))
(defun lookup-and-switch-to (basename)
  (defun lookup-file nil
    (car (cdr (lookup-pair))))
  (defun lookup-pair nil
    (assoc basename (find-files (project-root))))
  (find-file (concat (project-root) (lookup-file))))

(defun find-files (project-root)
  "Find all the files in a project, and create a list of dotted pairs,
with the complete path name as the cdr, and the abbreviated path name as the car"
  (defun find-all-files (directory-root &optional shell-cmd)
    (unless shell-cmd
      (setf shell-cmd "find ."))
    (save-excursion
      (with-temp-buffer
        (cd directory-root)
        (split-string (shell-command-to-string shell-cmd)))))

  (mapcar
   (lambda (file) (list (basename file) file))
   (find-all-files project-root (find-command))))

(defun find-command nil
  (cond ((project-root)
         (read (read-file 
                (concat (project-root) ".emproj"))))
        ((rails-root)
         "find . | grep '.rb\\|.rhtml' | grep -v .svn | grep -v '\#' | grep -v '\~'")))

;;;;;;;;;;;;;;;;;;
;;              ;;
;; Keymappings  ;;
;;              ;;
;;;;;;;;;;;;;;;;;;

(global-set-key "\C-xp" 'interactive-find-in-project)

   

