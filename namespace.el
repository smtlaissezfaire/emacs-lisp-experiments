
(add-to-list 'load-path ".")
(load "namespace-code.el")

(namespace-file
 'namespace
 "namespace-code.el")

; Remove the bootstrap
(namespace-undef-file-function-definitions "namespace-code.el")


 