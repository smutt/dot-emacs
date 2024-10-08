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
 '(custom-enabled-themes '(sanityinc-tomorrow-night))
 '(custom-safe-themes
   '("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default))
 '(inhibit-startup-screen t)
 '(js-indent-level 2)
 '(mediawiki-site-alist
   '(("Wikipedia" "https://en.wikipedia.org/w/" "username" "password" nil "Main Page")
     ("DorkyDwarves" "https://falcon.depht.com" "BreeLightfoot" "" "No" "Dorky Dwarves Community Wiki")))
 '(package-selected-packages
   '(markdown-mode mediawiki php-mode color-theme-sanityinc-tomorrow))
 '(show-paren-mode t)
 '(transient-mark-mode t))

(setq column-number-mode t)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-themed ((((min-colors 88) (class color)) (:background "black" :foreground "green")))))

;; Show which function our cursor is currently in
(which-function-mode 1)

;; Load everything under ~/hacking/elisp recursively
;;(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
;;	(let* ((my-lisp-dir "~/hacking/elisp/")
;;		(default-directory my-lisp-dir))
;;	(setq load-path (cons my-lisp-dir load-path))
;;	(normal-top-level-add-subdirs-to-load-path)))

;; Setup the melpa emacs packaging system
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; Set up Tramp
(setq tramp-default-method "ssh")
(customize-set-variable 'tramp-default-method "ssh")
(setq tramp-default-user "smutt")
;; Disable version control for tramp files
(setq vc-ignore-dir-regexp
  (format "\\(%s\\)\\|\\(%s\\)"
    vc-ignore-dir-regexp
      tramp-file-name-regexp))

;; Enable tramp debugging
;;(setq tramp-debug-buffer t)
;;(setq tramp-verbose 10)

;; Disable auto-save and backups since it does nothing but piss me off
(setq auto-save-default nil)
(setq backup-inhibited t)

;; abbrev-mode causes more trouble than its worth
(setq abbrev-file-name "/dev/null")

;; Disable tabs in indentation
(set-default 'indent-tabs-mode nil)

;; Zap trailing whitespace before any save
;;(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; recent files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; Default indenting if not based on mode
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)

;; Decided in April 2022 to stop using downloaded major modes from Github and other places
;; They should be installed using MELPA if needed
;; Uncomment language specific sections below if needed, but they shouldn't be

;; Uncomment if editing R files
;; ESS for R stuff
;; Disable changing _ into <-
;;(require 'ess-site)
;; (ess-toggle-underscore nil)

;; PHP mode
;;(require 'php-mode)

;; Go mode
;;(autoload 'go-mode "go-mode" nil t)
;;(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

;; Rust mode
;;(autoload 'rust-mode "rust-mode" nil t)
;;(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

;; autoload XSL mode and enable font-lock
;; Then set it to autoload on certain file extensions
;;(autoload 'xsl-mode "xslide" "Major mode for XSL stylesheets." t)
;;(add-hook 'xsl-mode-hook 'turn-on-font-lock)
;;(setq auto-mode-alist
;;  (append
;;    (list
;;    '("\\.fo" . xsl-mode)
;;    '("\\.xsl" . xsl-mode)
;;    '("\\.xslt" . xsl-mode))
;;    auto-mode-alist))

;; Perl
;;(setq perl-indent-level 2)

;; C
;;(setq c-mode-hook
;;   (function (lambda ()
;;    (setq indent-tabs-mode nil)
;;    (setq c-indent-level 4))))

;; PHP
(add-hook 'php-mode-hook #'(lambda() (setq c-basic-offset 2)))
;;(setq c-basic-offset 2)

;; Python
(add-hook 'python-mode-hook #'(lambda ()
  (setq python-indent 2)))
(setq py-indent-offset 2)
(setq-default python-indent 2)

;; JavaScript
;;(setq js-indent-level 2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Buffers / Windows / Frames ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Replace buffer-mode with iBuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
(add-hook 'ibuffer-mode-hook (lambda () (ibuffer-auto-mode 1)))

;; Hide buffers starting with *
(require 'ibuf-ext)
(add-to-list 'ibuffer-never-show-predicates "^\\*")

(setq initial-frame-alist '((top . 1) (left . 1)))
(set-frame-size (selected-frame) 220 100)

(split-window-right -80)
(other-window 1)
(ibuffer)
(other-window -1)

;; This does not work
;;(setq ibuffer-saved-filter-groups
;;  '(("remote"
;;    ("remote2" (name  . "/ssh:.+")))))
