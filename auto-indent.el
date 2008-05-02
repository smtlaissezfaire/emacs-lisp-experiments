;;
;; taken from the emacs wiki, with slight modifications:  
;;
;; http://www.emacswiki.org/cgi-bin/emacs/AutoIndentation
;;

;; use C-j to auto-indent a newline.  Or bind it to return:
;;
;;    (add-hook 'ruby-mode-hook '(lambda ()
;;      (local-set-key (kbd "RET") 'newline-and-indent)))

(defvar autoindent-modes '(scheme-mode 
                           lisp-mode
                           ruby-mode
                           c-mode 
                           c++-mode 
                           objc-mode
                           latex-mode 
                           plain-tex-mode))

(defadvice yank (after indent-region activate)
  (if (member major-mode '(emacs-lisp-mode autoindent-modes))
      (indent-region (region-beginning) (region-end) nil)))

(defadvice yank-pop (after indent-region activate)
  (if (member major-mode '(emacs-lisp-mode autoindent-modes))
      (indent-region (region-beginning) (region-end) nil)))

(defun kill-and-join-forward (&optional arg)
  (interactive "P")
  (if (and (eolp) (not (bolp)))
      (progn (forward-char 1)
             (just-one-space 0)
             (backward-char 1)
             (kill-line arg))
    (kill-line arg)))

(global-set-key "\C-k" 'kill-and-join-forward)