(load "namespace-code")

(namespace-file
 'namespace
 "namespace-code.el")

(functionp 'namespace-file)
(functionp 'namespace-namespace-file)

(defun namespace-undef-functions (list-of-functions)
  (cond
   ((eq list-of-functions nil) (quote ()))
   ((fmakunbound (intern (car list-of-functions)))
    (namespace-undef-functions (cdr list-of-functions)))))


; Remove the bootstrap
(namespace-undef-functions
 (find-function-names
  (read-file "namespace-code.el")))

(defalias 'namespace 'namespace-namespace-file)
