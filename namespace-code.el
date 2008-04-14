
; Ripped off from steve yegge's blog...thanks to whoever wrote it
(defun gsub (search-string replace string &optional regexp-flag)
  "Like Ruby gsub."
  (with-temp-buffer
    (insert string)
    (goto-char (point-min))
    (let ((search-function (if regexp-flag 're-search-forward 'search-forward)))
      (while (funcall search-function search-string nil t)
        (replace-match replace))
      (buffer-string))))

(defun append-in-namespace (string-namespace function-names text)
  "Given a list of function-names, append the string-namespace to each name,
returning the text originally given with the appending in place"
  (cond ((eq function-names ())
         text)
        ((append-in-namespace string-namespace
                              (cdr function-names)
                              (gsub (car function-names)
                                    (concat string-namespace
                                            (car function-names))
                                    text)))))

(defun find-function-names (text)
  "Returns a list of function names in text"
  (re-string-match "(defun \\([a-zA-Z\\-]*\\) " text))


(defun re-string-match (regexp text)
  "Retuns a list containing the matches"
  (cond ((eq text nil)
         (quote ()))
        ((eq (string-match regexp text) nil)
         (quote ()))
        (
         (cons (match-string 1 text)
               (re-string-match regexp
                                (nthcdr-string (match-end 1) text))))))

(defun nthcdr-string (num text)
  (apply 'string (nthcdr num (string-to-list text))))

(defun create-namespace (name-of-namespace function-string)
  (eval
   (append-in-namespace (concat (symbol-name name-of-namespace) "-")
                        (find-function-names function-string)
                        function-string)))

(defun read-file (filename)
  (with-temp-buffer
    (insert-file-contents filename)
    (goto-char (point-min))
    (read (current-buffer))))

(defun namespace (a-namespace filename)
  (create-namespace a-namespace 
                    (read-file filename)))

