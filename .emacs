(setq frame-title-format "FIGHTING")
(defun my-maximized ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
)
(my-maximized)
(mouse-avoidance-mode 'banish)

(global-set-key "\C-x?" 'help-command)
(global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\C-\M-h" 'backward-kill-word)
(global-set-key [C-left] 'previous-buffer)
(global-set-key [C-right] 'next-buffer)
(global-set-key [C-tab] 'other-window)
(global-set-key [M-f1] 'next-buffer)
(global-set-key [M-f2] 'previous-buffer)
(global-set-key [M-f3] 'other-window)

(add-hook 'c-mode-hook 
	  (lambda () (define-key c-mode-map "\C-\M-h" 'backward-kill-word)))
(add-hook 'c++-mode-hook 
	  (lambda () (define-key c++-mode-map "\C-\M-h" 'backward-kill-word)))

(global-set-key "\M-p" '( lambda() (interactive) (move-to-window-line 0) ) )
(global-set-key "\M-n" '( lambda() (interactive) (move-to-window-line -1) ) )

(setq scroll-conservatively 10000) ;;when beyond the last line of the window, do NOT scroll half window lines.

(setq inhibit-startup-message t) ;;close startup message
(setq transient-mark-mode t) ;;highlight selected region

(setq backup-directory-alist '(("." . "~/.emacs.backups"))) ;; the backup files named xxx~ will in the directory: ~/.emacs.backups

;;;;; for lisp start
;
;;; whether query when open a file with local variables
;(setq enable-local-variables 'nil)
;;(setq enable-local-eval 't)
;
;(setq inferior-lisp-program "/usr/bin/clisp -I") ;; run lisp
;;(setq inferior-lisp-program "/home/rock/bin/sbcl") ;; run lisp
;(autoload 'common-lisp-indent-function "cl-indent")
;(setq lisp-indent-function 'common-lisp-indent-function)
;
;;; set for slime
;(add-to-list 'load-path "/home/rock/Downloads/lisp/slime/cvs-source/slime")
;(require 'slime)
;(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
;(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
;(slime-setup)
;
;;; Define the program to be called by M-x run-lisp.
;;; Add new keybindings: C-x C-e evaluates the *next* form,
;;; C-x C-m macroexpands the next form.
;;(defun lisp-eval-sexp (&optional and-go)
;;  "Send the next sexp to the inferior Lisp process.
;;            Prefix argument means switch to the Lisp buffer afterwards."
;;  (interactive "P")
;;  (lisp-eval-region (point) (scan-sexps (point) 1) and-go))
;;(defun lisp-macroexpand-region (start end &optional and-go)
;;  "Macroexpand the current region in the inferior Lisp process.
;;            Prefix argument means switch to the Lisp buffer afterwards."
;;  (interactive "r\nP")
;;  (comint-send-string
;;   (inferior-lisp-proc)
;;   (format "(macroexpand-1 (quote %s))\n"
;;	   (buffer-substring-no-properties start end)))
;;  (if and-go (switch-to-lisp t)))
;;(defun lisp-macroexpand-sexp (&optional and-go)
;;  "Macroexpand the next sexp in the inferior Lisp process.
;;            Prefix argument means switch to the Lisp buffer afterwards."
;;  (interactive "P")
;;  (lisp-macroexpand-region (point) (scan-sexps (point) 1) and-go))
;
;;; Define the great keybindings.
;;(inferior-lisp-install-letter-bindings)
;;(define-key lisp-mode-map          "\C-x\C-e" 'lisp-eval-sexp)
;;(define-key inferior-lisp-mode-map "\C-x\C-e" 'lisp-eval-sexp)
;;(define-key lisp-mode-map          "\C-x\C-m" 'lisp-macroexpand-sexp)
;;(define-key inferior-lisp-mode-map "\C-x\C-m" 'lisp-macroexpand-sexp)
;;;;; for lisp stop

(setq c-basic-offset 8)
(setq indent-tab-mode nil)

(tool-bar-mode)
(menu-bar-mode)
(scroll-bar-mode)

(blink-cursor-mode ) ;; cursor do not flash
(setq ring-bell-function 'ignore) ;; close the bell

(set-background-color "DarkSlateGray")
(set-foreground-color "gray")

(set-cursor-color "orchid")
(set-default-font "DejaVu Sans Mono-13")

(setq display-time-24hr-format t)
(display-time-mode 1) ;; show time

;(set-frame-width (selected-frame) 200)
;(set-frame-height (selected-frame) 100)
(put 'upcase-region 'disabled nil)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((((class color) (min-colors 88) (background dark)) (:foreground "dim grey")))))

(require 'xcscope)
