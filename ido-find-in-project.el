;;;; Find in project, Interactive
;; Basic idea:
;; 1. Set project root
;; 2. Use an interactive fuzzy-match against a string
;; 3. Make it interactive, so that files can be cycled through

(add-to-list 'load-path ".")
(load "utils")

(defvar *rails-environment-file* "config/environment.rb")

;; Define rails-root if it's not around
(unless (functionp 'rails-root)
  ;; Taken from rinari
  (defun rails-root (&optional dir)
    (or dir (setq dir default-directory))
    (if (file-exists-p (concat dir *rails-environment-file*))
        dir
      (if (equal dir  "/")
          nil
        (rails-root (expand-file-name (concat dir "../")))))))

(defun interactive-find-in-project nil
  (defun interactive-find-in-project-prompt (prompt choices)
    "Use iswitch as a completing-read replacement to choose from
choices.  PROMPT is a string to prompt with.  CHOICES is a list of
strings to choose from."
    (let ((iswitchb-make-buflist-hook
           (lambda ()
             (setq iswitchb-temp-buflist choices))))
      (iswitchb-read-buffer prompt)))

  (lookup-and-switch-to 
   (interactive-find-in-project-prompt "find-in-project: "
                                       (firsts (find-files (rails-root))))))

(defun firsts (list)
  (mapcar
   (lambda (pair) (car pair))
   list))

(defun lookup-and-switch-to (basename)
  (defun lookup-file nil
    (car (cdr (lookup-pair))))
  (defun lookup-pair nil
    (assoc basename (find-files (rails-root))))
  (find-file (concat (rails-root) (lookup-file))))

(defun find-in-project (prefix)
  (cond ((rails-root)
         (fip-fuzzy-match prefix
                          (find-files (rails-root))))))

(defun fip-fuzzy-match (string list)
  (fip-match-with-regexp (explode-to-regexp string)
                         (mapcar (lambda (lst) (car lst))
                                 list)))

(defun fip-match-with-regexp (regexp lst)
  "Return the elements of list lst which match the regular expression regexp"
  (remove-if-not
   (lambda (str) 
     (eql-match-p str regexp)) 
   lst))

(defun explode-to-regexp (string)
  "Explode a string to a regular expression, where each char has a .* in front and back of it"
  (apply 'concat (explode-to-regexp-list string)))

(defun explode-to-regexp-list (string)
  "Explode a string to a list of chars, where each char has a .* in front and back of it"
  (cons ".*" 
        (mapcar 'char-exploded-to-regexp string)))

(defun char-exploded-to-regexp (char)
   (concat (string char) ".*"))

(defun find-all-files (directory-root &optional shell-commandf)
  (unless shell-commandf 
    (setf shell-commandf "find ."))
  (with-temp-buffer
    (cd directory-root)
    (shell-command shell-commandf (current-buffer))
    (split-string (buffer-string))))

(defun find-files (project-root)
  "Find all the files in a project, and create a list of dotted pairs,
with the complete path name as the cdr, and the abbreviated path name as the car"
  (mapcar
   (lambda (file) (list (basename file) file))
   (find-all-files project-root (concat "find app spec | " (grep-to-ignore)))))

(defun grep-to-ignore nil
  "grep .rb | grep -v .svn | grep -v '\#'")
