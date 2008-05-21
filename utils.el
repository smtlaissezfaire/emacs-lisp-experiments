;; Lists
(defun empty-p (list)
  (eq list nil))

;; Regexps
(defun eql-match-p (string regexp)
  "Tests for regexp equality"
  (with-temp-buffer
    (insert string)
    (goto-char (point-min))
    (search-forward-regexp regexp (point-max) t)))

;; Files
(defun basename (file)
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

  (cond ((string-with-slash-p file)
         (basename (strip-to-slash file)))
        (file)))

;; Strings
(defun string-offset (counter)
  (+ 1 counter))
                
(defun firsts (list)
  (mapcar
   (lambda (pair) (car pair))
   list))

;; emacs functions
(defun indent-current-buffer nil
  (interactive)
  (beginning-of-buffer)
  (push-mark)
  (end-of-buffer)
  (indent-region 0 (length (buffer-string))))
