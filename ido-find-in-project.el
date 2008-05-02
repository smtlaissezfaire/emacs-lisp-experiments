;;;; Find in project, Interactive
;; Basic idea:
;; 1. Set project root
;; 2. Use an interactive fuzzy-match against a string
;; 3. Make it interactive, so that files can be cycled through

(defvar project-root "~/src/svn/flavorpill/flavorpill_com/trunk")

(defun fip-fuzzy-match (string list)
  (fip-match-with-regexp (explode-to-regexp string) list))

(defun empty-p (list)
  (eq list nil))

(defun fip-match-with-regexp (regexp list)
  "Return the elements of list which match the regular expression regexp"
  (defun eql-match-p (string)
    "Equivalent to ruby's =~"
    (with-temp-buffer
      (insert string)
      (goto-char (point-min))
      (search-forward-regexp regexp (point-max) t)))
  (remove-if-not 'eql-match-p list))


(defun explode-to-regexp (string)
  "Explode a string to a regex, where each char has a .* in front and back of it"
  (regexp-quote (apply 'concat (explode-to-regexp-list string))))

(defun explode-to-regexp-list (string)
  (cons "\.\*" 
        (mapcar 'char-exploded-to-regexp string)))

(defun char-exploded-to-regexp (char)
   (concat (string char) ".*"))

(defun recursive-find-files (directory-root)
  (with-temp-buffer
    (cd directory-root)
    (shell-command "find app config db lib test spec | grep -v .svn" (current-buffer))
    (split-string (buffer-string))))

(find-all-files project-root)

(fip-fuzzy-match "app" (find-all-files project-root))

