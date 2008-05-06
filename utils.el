(defun empty-p (list)
  (eq list nil))

(defun eql-match-p (string regexp)
  "Tests for regexp equality"
  (with-temp-buffer
    (insert string)
    (goto-char (point-min))
    (search-forward-regexp regexp (point-max) t)))


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
                
