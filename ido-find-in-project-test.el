
(load "ido-find-in-project")

;;  (deftest "explode-to-regexp should explode the item properly"
(equal
 (explode-to-regexp "foo")
 ".*f.*o.*o.*")
;;  (defexploratory "explode-to-regexp should explode the item properly"
(equal
 (explode-to-regexp-list "foo")
 (list ".*"
       "f.*"
       "o.*"
       "o.*"))

;; (describe "fip-fuzzy-match"
;; (describe "given two elements" 
;; (it "should fuzzy match one element with the same start name"
(equal
 (fip-fuzzy-match "foo" (list (list "foobar" "/foo/bar/foobar")))
 (list "foobar"))
;; (it "should fuzzy match one element with the same end name"
(equal
 (fip-fuzzy-match "bar" (list (list "foobar" "adsfadsf")))
 (list "foobar"))
;; (it "should not match any elements with bar and baz
(equal
 (fip-fuzzy-match "baz" (list (list "bar" "bar/baz/foo")))
 '())
                  
;; describe "rails-root"
;; it "should have the function rails-root around"
(functionp 'rails-root)

