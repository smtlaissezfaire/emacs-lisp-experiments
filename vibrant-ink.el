(defun set-theme-to-vibrant-ink ()
                                        
  (setq font-lock-maximum-decoration t)

  ;; set colors:
  (set-background-color "black")
  (set-foreground-color "white")

  (set-face-foreground font-lock-type-face "white")

  ;; comment: magenta4
  (set-face-foreground font-lock-comment-face "magenta4")

  ;; symbols (constants): dark cyan
  (set-face-foreground font-lock-constant-face "dark cyan")

  ;; keyword: orange red
  (set-face-foreground font-lock-keyword-face "orange red")

  ;; function-name: orange
  (set-face-foreground font-lock-function-name-face "orange")

  ;; string: green
  (set-face-foreground font-lock-string-face "green")

  ;; I'm not sure how these should be set

  ;; block comment: dark violet
  ;; regex: cyan
  ;; (set-face-foreground font-lock-regexp-grouping-backslash "cyan")
)
