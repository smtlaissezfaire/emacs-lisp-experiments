;;;; Find in project, Interactive
;; Basic idea:
;; 1. Set project root
;; 2. Use an interactive fuzzy-match against a string
;; 3. Make it interactive, so that files can be cycled through

(defun fip-fuzzy-match (string list)
  (fip-match-with-regexp (explode-to-regexp string) list))

(fip-match-with-regexp "foobar" (directory-files "."))

(defun empty-p (list)
  (eq list nil))

(defun fip-match-with-regexp (regexp list)
  "Return the elements of list which match the regular expression regexp"
  (cond ((empty-p list)
         (quote ()))
        ((eql-match-p regexp (car list))
         (cons (car (list))
               (fip-match-with-regexp (regexp (cdr list)))))
        (fip-match-with-regexp (regexp (cdr list)))))

(defun eql-match-p (regexp string)
  "Equivalent to ruby's =~"
  (with-temp-buffer
    (insert string)
    (goto-char (point-min))
    (search-forward-regexp regexp (point-max) t)))

(defun explode-to-regexp (string)
  "Explode a string to a regex, where each char has a .* in front and back of it"
  (regexp-quote (apply 'concat (explode-to-regexp-list string))))

(defun explode-to-regexp-list (string)
  (cons ".*" 
        (mapcar 'char-exploded-to-regexp string)))

(defun fip-char-exploded-to-regexp (char)
   (concat (string char) ".*"))
