;; -*- coding: utf-8; lexical-binding: t -*-

;; custom goes in separate file
(setq custom-file (concat user-emacs-directory "ywy/custom.el"))
(load custom-file 'noerror)

;; Sets all files to be backed up and auto saved in a single directory.
(defvar emacs-autosave-directory temporary-file-directory)
(setq backup-directory-alist
      `((".*" . ,emacs-autosave-directory))
      auto-save-file-name-transforms
      `((".*" ,emacs-autosave-directory t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; interface config
;; (mostly done in early-init.el)
(setq inhibit-startup-message t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; always prefer utf-8
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)
(put 'narrow-to-region 'disabled nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; misc. 
(setq visible-bell t)

(column-number-mode)
(global-display-line-numbers-mode nil)
(global-hl-line-mode 1)

(delete-selection-mode 1)
(column-number-mode 1)
(show-paren-mode 1)
;(defalias 'yes-or-no-p 'y-or-n-p)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; packages
;; based on https://github.com/MatthewZMD/.emacs.d/blob/master/elisp/init-package.el
;; https://github.com/gilbertw1/emacs-literate-starter/blob/master/emacs.org

;; initialize package manager
(eval-and-compile
  (setq load-prefer-newer t
        package-user-dir (expand-file-name "elpa" user-emacs-directory)
        package--init-file-ensured t
        package-enable-at-startup nil)

  (unless (file-directory-p package-user-dir)
    (make-directory package-user-dir t)))
  
(eval-and-compile
  (setq load-path (append load-path (directory-files package-user-dir t "^[^.]" t))))

;; set use-package-verbose to t for interpreted .emacs,
;; and to nil for byte-compiled .emacs.elc.
(eval-and-compile
  (setq use-package-verbose (not (bound-and-true-p byte-compile-current-file))))

(eval-when-compile
  (require 'package)
  (unless (assoc-default "melpa" package-archives)
    (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t))
  (unless (assoc-default "org" package-archives)
    (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t))

  (package-initialize)
  (require 'use-package)
  (setq use-package-always-ensure t)
  (setq use-package-expand-minimally byte-compile-current-file)
  (setq use-package-compute-statistics t)
  (setq use-package-enable-imenu-support t)
  (require 'diminish)
  (require 'bind-key))

(if init-file-debug
	(setq use-package-verbose t
		  use-package-expand-minimally nil
		  use-package-compute-statistics t
		  debug-on-error t)
	(setq use-package-verbose nil
		  use-package-expand-minimally t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; diminish
;; unclutter minor modes
;; use-package :diminish


;; use-package :bind


(provide 'ywy-preferences)