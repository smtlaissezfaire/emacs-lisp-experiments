(load "namespace-code")

(namespace-file
 'namespace
 "namespace-code.el")

(functionp 'namespace-file)
(functionp 'namespace-namespace-file)

; Remove the bootstrap
(namespace-undef-functions
 (namespace-find-function-names
  (read-file "namespace-code.el")))

(defalias 'namespace 'namespace-namespace-file)
