;; Some fuzzy matching stuff which was never completed - iswitchb
;; took its place.  For now, this code is just sitting here

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
