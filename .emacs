(setq frame-title-format "FIGHTING")
;; (mouse-avoidance-mode 'banish)

(global-set-key "\C-x?" 'help-command)
(global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\C-\M-h" 'backward-kill-word)
(global-set-key [C-left] 'previous-buffer)
(global-set-key [C-right] 'next-buffer)
;; (global-set-key [C-tab] 'other-window)
;; (global-set-key [M-f1] 'next-buffer)
;; (global-set-key [M-f2] 'previous-buffer)
;; (global-set-key "\C-[" 'previous-buffer)
;; (global-set-key "\C-]" 'next-buffer)
(global-set-key (kbd "C-;") 'other-window)
(global-set-key (kbd "C-'") 'switch-to-buffer)
;; (global-set-key (kbd "C-,") '( lambda() (interactive) (backward-delete-char 4))) ; for python indent back

(c-set-offset 'substatement-open 0)

(add-hook 'c-mode-hook
	  (lambda ()
            ;; (setq c-default-style "linux")
            (define-key c-mode-map "\C-\M-h" 'backward-kill-word)))
(add-hook 'c++-mode-hook
	  (lambda () 
            ;; (setq c-default-style "linux")
            (define-key c++-mode-map "\C-\M-h" 'backward-kill-word)))
(add-hook 'java-mode-hook
	  (lambda ()
            (define-key java-mode-map "\C-\M-h" 'backward-kill-word)))

(global-set-key "\M-p" '( lambda() (interactive) (move-to-window-line 0) ) )
(global-set-key "\M-n" '( lambda() (interactive) (move-to-window-line -1) ) )

;; (setq scroll-conservatively 0) ;;when beyond the last line of the window, do NOT scroll half window lines.
;; (show-paren-mode t)
;; (setq show-paren-style 'parentheses) ;; 设置显示括号匹配，但不跳转
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
;; (defun linux-c-mode ()
;;   "C mode with adjusted defaults for use with the Linux kernel."
;;   (interactive)
;;   (c-mode)
;;   (c-set-style "K&R")
;;   (setq tab-width 8)
;;   (setq indent-tabs-mode t)
;;   (setq c-basic-offset 8))
;; (setq auto-mode-alist (cons '("/home/Aphrodite/program/kernel/.*\\.[ch]$" . linux-c-mode)
;; 			    auto-mode-alist))
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

(blink-cursor-mode) ;; cursor do not flash
(setq ring-bell-function 'ignore) ;; close the bell

(set-background-color "DarkSlateGray")
(set-foreground-color "gray")

(set-cursor-color "orchid")
(set-default-font "DejaVu Sans Mono-10")
;; (set-default-font "Monaco-10")
;;(set-default-font "Inconsolata-12")
;;(set-default-font "Monofur-12")

(setq display-time-24hr-format t)
(display-time-mode 1) ;; show time

;; (set-frame-width (selected-frame) 200)
;; (set-frame-height (selected-frame) 100)
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
 '(font-lock-comment-face ((((class color) (min-colors 88) (background dark)) (:foreground "dim grey"))))
 '(font-lock-keyword-face ((((class color) (min-colors 88) (background dark)) (:foreground "cyan3")))))

(add-to-list 'load-path
	     "~/.emacs.d/plugins/yasnippet-0.6.1c")
(require 'yasnippet)
(yas/initialize)
(setq yas/root-directory "~/.emacs.d/Aphrodite_snippets")
(yas/load-directory yas/root-directory)
(setq yas/triggers-in-field t)

;; lisp
(setq inferior-lisp-program "/usr/bin/sbcl")
(add-to-list 'load-path "~/.emacs.d/plugins/slime")
(require 'slime-autoloads)
(slime-setup '(slime-fancy))
;; (require 'slime)
;; (slime-setup)
(setq common-lisp-hyperspec-root "/home/Aphrodite/Documents/LISP/HyperSpec/")
(setq browse-url-browser-function
      '(("/home/Aphrodite/Documents/LISP/HyperSpec/" . w3m-browse-url)
        ("." . browse-url-default-browser)))
(defun lisp-indent-or-complete (&optional arg)
  (interactive "p")
  (if (or (looking-back "^\\s-*") (bolp))
      (call-interactively 'lisp-indent-line)
    (progn
      (call-interactively 'slime-indent-and-complete-symbol))))
      ;; (local-set-key (kbd "C-g") (lambda ()
      ;;                              (interactive)
      ;;                              (switch-to-buffer-other-window "*Completions**")
      ;;                              (bury-buffer)
      ;;                              (other-window 1))))))
(eval-after-load "lisp-mode"
  '(progn
     (define-key lisp-mode-map (kbd "TAB") 'lisp-indent-or-complete)))

;; haskell
(add-to-list 'load-path "~/.emacs.d/plugins/haskell-mode")
(load "~/.emacs.d/plugins/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
(add-hook 'inferior-haskell-mode-hook
	  (lambda () (define-key inferior-haskell-mode-map "\C-j"
                       'comint-send-input)))
;; (add-hook 'haskell-mode-hook
;;           (lambda () (define-key haskell-mode-map "\C-c\C-g"
;;                        'haskell-indent-insert-guard)))


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
    (setq extention-alist ;; a keyed list of file suffix to comand-line program to run
          '(
	    ("cpp" . "g++ -Wall -o /tmp/a.out")
            ;; ("cpp" . "g++ -Wall -o /tmp/a.out -lglut -lGL -lGLU -lm -I /home/Aphrodite/program/openGL/src/examples/src/shared -I /usr/include/GL")
	    ("c"   . "gcc -Wall -o /tmp/a.out")
	    ("py"  . "/usr/bin/time -f \"***** Time %Us *****\" python")
            ("hs"  . "ghc -o /tmp/a.out -outputdir /tmp -tmpdir /tmp")
            ("lisp" . "/usr/bin/time -f \"***** Time %Us *****\" sbcl --script")
            ;; ("sh" . "bash")
            )
          )
    (setq fileStr-alist
	  '(
	    ("cpp" . " && /usr/bin/time -f \"***** Time %Us *****\" /tmp/a.out")
	    ("c"   . " && /usr/bin/time -f \"***** Time %Us *****\" /tmp/a.out")
	    ("py"  . "")
            ("hs"  . " && /usr/bin/time -f \"***** Time %Us *****\" /tmp/a.out")
            ("lisp" . "")
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
      )))
(defun compile-and-run-current-file-debug ()
  (interactive)
  (let (extention-alist fileStr-alist fname suffix progName cmdStr)
    (setq extention-alist ;; a keyed list of file suffix to comand-line program to run
          '(
	    ("cpp" . "g++ -DDEBUG -Wall -o /tmp/a.out")
	    ("c"   . "gcc -DDEBUG -Wall -o /tmp/a.out")
	    ("py"  . "/usr/bin/time -f \"***** Time %Us *****\" python")
            ;; ("sh" . "bash")
            )
          )
    (setq fileStr-alist
	  '(
	    ("cpp" . " && /usr/bin/time -f \"***** Time %Us *****\" /tmp/a.out")
	    ("c"   . " && /usr/bin/time -f \"***** Time %Us *****\" /tmp/a.out")
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
      )))
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
;; (enlarge-window-horizontally 20)

;; (ansi-term "/home/Aphrodite/bin/tmux.sh")
;; (ansi-term "/bin/bash")
;; (setq eshell-aliases-file "~/.emacs.d/eshell-conf/alias")
;; (setenv "PATH" (concat "/home/rock/bin" ":" (getenv "PATH")))
;; (eshell)

;; emms
;; (add-to-list 'load-path "~/.emacs.d/plugins/emms-3.0/")
;; (require 'emms-setup)
;; (emms-standard)
;; (emms-default-players)

;;############### Session.el ###############
;; (require 'session)
;; (add-hook 'after-init-hook 'session-initialize)
;;############### Desktop Reload ###############
;; (load "desktop")
;; (add-to-list 'desktop-modes-not-to-save 'dired-mode)
;; (add-to-list 'desktop-modes-not-to-save 'Info-mode)
;; (add-to-list 'desktop-modes-not-to-save 'info-lookup-mode)
;; (add-to-list 'desktop-modes-not-to-save 'fundamental-mode)
;; ;; use only one desktop
;; (setq desktop-path '("~/.emacs.d/"))
;; (setq desktop-dirname "~/.emacs.d/")
;; (setq desktop-base-file-name "emacs-desktop")
;; (desktop-save-mode t)

;; w3m config
(add-to-list 'load-path "~/.emacs.d/plugins/w3m/")
(require 'w3m-load)
;; (setq w3m-home-page "file:///home/Aphrodite/Documents/c++_primer4/html/0201721481/toc.html")

;; (add-to-list 'load-path "~/.emacs.d/plugins/sdcv")
;; (require 'showtip)
;; (require 'sdcv)

;; sdcv
(global-set-key (kbd "C-c d") 'kid-sdcv-to-buffer)
(defun kid-sdcv-to-buffer()
  (interactive)
  (let ((word (if mark-active
                  (buffer-substring-no-properties (region-beginning) (region-end))
                (current-word nil t))))
    (setq word (read-string (format "Enter word (default: %s): " word)
                            nil nil word))
    (set-buffer (get-buffer-create "*sdcv*"))
    (buffer-disable-undo)
    (erase-buffer)
    ;; 在没有创建 *sdcv* windows 之前检查是否有分屏(是否为一个window)
    ;; 缺憾就是不能自动开出一个小屏幕，自己注销
    (if (null (cdr (window-list)))
        (setq onewindow t)
      (setq onewindow nil))
    (let ((process (start-process-shell-command "sdcv" "*sdcv*" "sdcv" "-n" word)))
      (set-process-sentinel
       process
       (lambda (process signal)
         (when (memq (process-status process) '(exit signal))
           (unless (string= (buffer-name) "*sdcv*")
             (setq kid-sdcv-window-configuration (current-window-configuration))
             (switch-to-buffer-other-window "*sdcv*")
             ;; (local-set-key (kbd "d") 'kid-sdcv-to-buffer)
             ;; (local-set-key (kbd "n") 'next-line)
             ;; (local-set-key (kbd "j") 'next-line)
             ;; (local-set-key (kbd "p") 'previous-line)
             ;; (local-set-key (kbd "k") 'previous-line)
             ;; (local-set-key (kbd "SPC") 'scroll-up)
             ;; (local-set-key (kbd "DEL") 'scroll-down)
             (local-set-key (kbd "C-g") (lambda ()
                                          (interactive)
                                          (if (eq onewindow t)
                                              (delete-window)
                                            (progn (bury-buffer) (other-window 1))))))
           (goto-char (point-min))))))))

(global-set-key (kbd "C-M-;") 'comment-and-copy)
(defun comment-and-copy()
  (interactive)
  (if mark-active
      (let ((lines (buffer-substring-no-properties (region-beginning) (region-end)))
            (lines-size (- (region-end) (region-beginning))))
        (comment-region (region-beginning) (region-end))
        (insert lines)
        (backward-char lines-size))))
