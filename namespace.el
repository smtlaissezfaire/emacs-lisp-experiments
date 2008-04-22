(load "namespace-code")

(namespace-file
 'namespace
 "namespace-code.el")

; Remove the bootstrap
(namespace-undef-functions
 (namespace-find-function-names
  (read-file "namespace-code.el")))

(defalias 'namespace 'namespace-namespace-file)
