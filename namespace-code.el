
(add-to-list 'load-path ".")
(load "cl.el")
(load "ruby.el")
(load "stringify.el")

(defun undef-file-function-definitions (filename)
  "Find the function definitions in a file, and undef each one"
  (undef-functions 
   (find-function-names
    (read-file filename))))

(defun undef-functions (list-of-functions)
  (cond
   ((eq list-of-functions nil) (quote ()))
   ((undef-function (car list-of-functions))
    (undef-functions (cdr list-of-functions)))))

(defalias 'undef-function 'fmakunbound)

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
  (eval-from-string
   (append-in-namespace (concat (symbol-name name-of-namespace) "-")
                        (find-function-names function-string)
                        function-string)))

(defun eval-from-string (string)
  (eval (car (read-from-string string))))

(defun namespace (a-namespace string)
  (create-namespace a-namespace string))

(defun namespace-file (a-namespace filename)
  (namespace a-namespace (read-file filename)))
