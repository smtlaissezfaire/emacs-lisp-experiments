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

(defun eql-match-p (string regexp)
  "Tests for regexp equality"
  (with-temp-buffer
    (insert string)
    (goto-char (point-min))
    (search-forward-regexp regexp (point-max) t)))

(defun fip-match-with-regexp (regexp list)
  "Return the elements of list which match the regular expression regexp"
  (remove-if-not (lambda (x) (eql-match-p list regexp)) list))

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
    (shell-command "find . | grep -v .svn | grep -v vendor | grep .rb" (current-buffer))
    (split-string (buffer-string))))

(defun basename (file)
  (cond ((string-with-slash-p file)
         (basename (strip-to-slash file)))
        (file)))

(defun string-with-slash-p (string)
  (not (eq (search "/" string) nil)))

(defun strip-to-slash (string)
  (let ((string-length (length string))
        (string-search (search "/" string)))
    (cond ((not (eq string-search nil))
           (subseq string
                   (string-offset string-search)
                   string-length))
          (string))))

(defun string-offset (counter)
  (+ 1 counter))
                
(mapcar (lambda (file) (basename file)) (recursive-find-files project-root))

(defun find-all-files (project-root)
  "Find all the files in a project, and create a list of dotted pairs,
with the complete path name as the car, and the abbreviated path name as the cdr"
  (mapcar
   (lambda (file) (list file (basename file)))
   (recursive-find-files project-root)))

(find-all-files project-root)


