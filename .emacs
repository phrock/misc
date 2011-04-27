(setq frame-title-format "FIGHTING")
;(mouse-avoidance-mode 'banish)

(global-set-key "\C-x?" 'help-command)
(global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\C-\M-h" 'backward-kill-word)
(global-set-key [C-left] 'previous-buffer)
(global-set-key [C-right] 'next-buffer)
;; (global-set-key [C-tab] 'other-window)
(global-set-key [M-f1] 'next-buffer)
(global-set-key [M-f2] 'previous-buffer)
(global-set-key (kbd "C-;") 'other-window)
(global-set-key (kbd "C-'") 'switch-to-buffer)
(global-set-key "\M-," '( lambda() (interactive) (backward-delete-char 4))) ; for python indent back


(add-hook 'c-mode-hook 
	  (lambda () (define-key c-mode-map "\C-\M-h" 'backward-kill-word)))
(add-hook 'c++-mode-hook 
	  (lambda () (define-key c++-mode-map "\C-\M-h" 'backward-kill-word)))

(global-set-key "\M-p" '( lambda() (interactive) (move-to-window-line 0) ) )
(global-set-key "\M-n" '( lambda() (interactive) (move-to-window-line -1) ) )

;(setq scroll-conservatively 0) ;;when beyond the last line of the window, do NOT scroll half window lines.
;(show-paren-mode t)
;(setq show-paren-style 'parentheses) ;; 设置显示括号匹配，但不跳转
(setq column-number-mode t)
(setq inhibit-startup-message t) ;;close startup message
(setq transient-mark-mode t) ;;highlight selected region
(setq make-backup-files         nil) ; Don't want any backup files
(setq auto-save-list-file-name  nil) ; Don't want any .saves files
(setq auto-save-default         nil) ; Don't want any auto saving
(setq backup-directory-alist '(("." . "~/.emacs.backups"))) ;; the backup files named xxx~ will in the directory: ~/.emacs.backups

(setq c-basic-offset 4)
;; (setq indent-tabs-mode nil)无效的原因是indent-tabs-mode是针对buffer的local变量,每当建立buffer时会自动取缺省值.
(setq-default indent-tabs-mode nil)

;; for kernel code
(defun linux-c-mode ()
  "C mode with adjusted defaults for use with the Linux kernel."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq tab-width 8)
  (setq indent-tabs-mode t)
  (setq c-basic-offset 8))
(setq auto-mode-alist (cons '("/home/rock/program/kernel/.*\\.[ch]$" . linux-c-mode)
			    auto-mode-alist))
;; (setq auto-mode-alist (cons '("/home/rock/test/.*\\.[ch]$" . linux-c-mode)
;; 			    auto-mode-alist))

;; ***** python *****
;; (add-to-list 'load-path
;; 	     "~/.emacs.d/plugins/python")
;; setup python-mode
;; (setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
;; (setq interpreter-mode-alist (cons '("python" . python-mode)
;;                                    interpreter-mode-alist))
;; (autoload 'python-mode "python-mode" "Python editing mode." t)
;; ------------------------------------------
;; setup pymacs
;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-exec "pymacs" nil t)
;; (autoload 'pymacs-load "pymacs" nil t)
;;(eval-after-load "pymacs"
;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))



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
;(display-time-mode 1) ;; show time

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

(add-to-list 'load-path
	     "~/.emacs.d/plugins/yasnippet-0.6.1c")
(require 'yasnippet)
(yas/initialize)
(setq yas/root-directory "~/.emacs.d/rock_snippets")
(yas/load-directory yas/root-directory)
(setq yas/triggers-in-field t)

;; for cscope
(add-to-list 'load-path
	     "~/.emacs.d/plugins/xcscope")
(add-hook 'c-mode-common-hook
	  '(lambda ()
	     (require 'xcscope)))
;; (define-key global-map "\C-j" 'cscope-select-entry-other-window)

;; Replace path below to be where your matlab.el file is.
;;(add-to-list 'load-path "~/.emacs.d/plugins/matlab-emacs")
;;(load-library "matlab-load")
;; Enable CEDET feature support for MATLAB code. (Optional)
;; (matlab-cedet-setup)

(defun compile-and-run-current-file ()
  "Execute or compile the current file.
For example, if the current buffer is the file x.pl,
then it'll call “perl x.pl” in a shell.
The file can be php, perl, python, ruby, javascript, bash, ocaml, java.
File suffix is used to determine what program to run."
  (interactive)
  (let (extention-alist fileStr-alist fname suffix progName cmdStr)
    (setq extention-alist ; a keyed list of file suffix to comand-line program to run
          '(
	    ("cpp" . "g++ -Wall -o /tmpfs/a.out")
	    ("c"   . "gcc -Wall -o /tmpfs/a.out")
	    ("py"  . "/usr/bin/time -f \"***** Time %Us *****\" python3")
            ;("sh" . "bash")
            )
          )
    (setq fileStr-alist
	  '(
	    ("cpp" . " && /usr/bin/time -f \"***** Time %Us *****\" /tmpfs/a.out")
	    ("c"   . " && /usr/bin/time -f \"***** Time %Us *****\" /tmpfs/a.out")
	    ("py"  . "")
	    )
	  )
    (setq fname (buffer-file-name))
    (setq suffix (file-name-extension fname))
    (setq progName (cdr (assoc suffix extention-alist)))
    (setq fileStr (cdr (assoc suffix fileStr-alist)))
    (setq cmdStr (concat progName " \""   fname "\"" fileStr))
    (if progName
	(progn
	  (message "Running...")
	  (async-shell-command cmdStr))
      (message "No recognized program file suffix for this file.")
      ) ))
(defun compile-and-run-current-file-debug ()
  (interactive)
  (let (extention-alist fileStr-alist fname suffix progName cmdStr)
    (setq extention-alist ; a keyed list of file suffix to comand-line program to run
          '(
	    ("cpp" . "g++ -DDEBUG -Wall -o /tmpfs/a.out")
	    ("c"   . "gcc -DDEBUG -Wall -o /tmpfs/a.out")
	    ("py"  . "/usr/bin/time -f \"***** Time %Us *****\" python3")
            ;("sh" . "bash")
            )
          )
    (setq fileStr-alist
	  '(
	    ("cpp" . " && /usr/bin/time -f \"***** Time %Us *****\" /tmpfs/a.out")
	    ("c"   . " && /usr/bin/time -f \"***** Time %Us *****\" /tmpfs/a.out")
	    ("py"  . "")
	    )
	  )
    (setq fname (buffer-file-name))
    (setq suffix (file-name-extension fname))
    (setq progName (cdr (assoc suffix extention-alist)))
    (setq fileStr (cdr (assoc suffix fileStr-alist)))
    (setq cmdStr (concat progName " \""   fname "\"" fileStr))
    (if progName
	(progn
	  (message "Running...")
	  (async-shell-command cmdStr))
      (message "No recognized program file suffix for this file.")
      ) ))
(global-set-key "\M-r" 'compile-and-run-current-file)
(global-set-key "\C-\M-r" 'compile-and-run-current-file-debug)

(defun my-maximized ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(1 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(1 "_NET_WM_STATE_MAXIMIZED_VERT" 0)))
(my-maximized)
(split-window-horizontally)
(enlarge-window-horizontally 20)
