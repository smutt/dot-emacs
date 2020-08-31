;; ____________________________________________________________________________
;; Aquamacs custom-file warning:
;; Warning: After loading this .emacs file, Aquamacs will also load
;; customizations from `custom-file' (customizations.el). Any settings there
;; will override those made here.
;; Consider moving your startup settings to the Preferences.el file, which
;; is loaded after `custom-file':
;; ~/Library/Preferences/Aquamacs Emacs/Preferences
;; _____________________________________________________________________________
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(show-paren-mode t)
 '(standard-indent 2)
 '(transient-mark-mode t))
 (custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(custom-themed ((((min-colors 88) (class color)) (:background "black" :foreground "green")))))

;; Show which function our cursor is currently in
(which-function-mode 1)

;; Load everything under ~/hacking/elisp recursively
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	(let* ((my-lisp-dir "~/hacking/elisp/")
		(default-directory my-lisp-dir))
	(setq load-path (cons my-lisp-dir load-path))
	(normal-top-level-add-subdirs-to-load-path)))

;; Setup our the melpa emacs packaging system
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; Set up our themes
(require 'color-theme)
(color-theme-initialize)
(color-theme-euphoria)

;; Set up Tramp
(setq tramp-default-method "ssh")
;; Disable version control for tramp files
(setq vc-ignore-dir-regexp
  (format "\\(%s\\)\\|\\(%s\\)"
    vc-ignore-dir-regexp
      tramp-file-name-regexp))
(setq tramp-verbose 10)

;; Disable auto-save since it does nothing but piss me off
(setq auto-save-default nil)

;; Disable tabs in indentation
(set-default 'indent-tabs-mode nil)

;; Zap trailing whitespace before any save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; recent files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; Uncomment if editing R files
;; ESS for R stuff
;; Disable changing _ into <-
;;(require 'ess-site)
;; (ess-toggle-underscore nil)

;; PHP mode
(require 'php-mode)

;; Go mode
(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

;; Rust mode
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

;; autoload XSL mode and enable font-lock
;; Then set it to autoload on certain file extensions
(autoload 'xsl-mode "xslide" "Major mode for XSL stylesheets." t)
(add-hook 'xsl-mode-hook 'turn-on-font-lock)
(setq auto-mode-alist
  (append
    (list
    '("\\.fo" . xsl-mode)
    '("\\.xsl" . xsl-mode)
    '("\\.xslt" . xsl-mode))
    auto-mode-alist))

;; Default indenting if not based on mode
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)

;; Set up our indenting by mode
;; Add a seperate section for each lang mode

;; Perl
(setq perl-indent-level 2)

;; C
(setq c-mode-hook 
  (function (lambda ()
    (setq indent-tabs-mode nil)
    (setq c-indent-level 4))))

;; PHP
;; (setq c-basic-offset 2)

;; Python
(add-hook 'python-mode-hook '(lambda () 
  (setq python-indent 2)))
(setq py-indent-offset 2)
(setq-default python-indent 2)

;; JavaScript
(setq js-indent-level 2)

