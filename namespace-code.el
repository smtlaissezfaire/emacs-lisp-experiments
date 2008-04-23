
(add-to-list 'load-path ".")
(load "cl.el")
(load "ruby.el")

(defun undef-functions (list-of-functions)
  (cond
   ((eq list-of-functions nil) (quote ()))
   ((fmakunbound (intern (car list-of-functions)))
    (namespace-undef-functions (cdr list-of-functions)))))

(defun append-in-namespace (string-namespace function-names text)
  "Given a list of function-names, append the string-namespace to each name,
returning the text originally given with the appending in place"
  (cond ((eq function-names ())
         text)
        ((real-append-in-namespace string-namespace function-names text))))

(defun real-append-in-namespace (string-namespace function-names text)
  (setq function-name (car function-names))
  (setq rest-of-functions (cdr function-names))
  (setq new-function-name (concat string-namespace function-name))
  (append-in-namespace string-namespace
                       rest-of-functions
                       (gsub function-name
                             new-function-name
                             text)))

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
  (set 'complete-string
       (append-in-namespace (concat (symbol-name name-of-namespace) "-")
                            (find-function-names function-string)
                            function-string))
  (eval-string complete-string)
  complete-string)
  

(defun eval-string (string &optional start)
  (or (numberp start) (set 'start 1))
  (cond ((not (eq start (- (length string) 1)))
         (set 'current-string (read-from-string string start))
         (eval (car current-string))
         (eval-string string (cdr current-string)))))

(defun namespace (a-namespace string)
  (create-namespace a-namespace string))

(defun namespace-file (a-namespace filename)
  (namespace a-namespace (read-file filename)))
