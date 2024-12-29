;;; early-init.el --- -*- lexical-binding: t -*-
;;
;; Filename: early-init.el
;; Description: Early initialization
;; Author: ywy
;; Created: 
;; Compatibility: emacs-version >= 27
;; This file is NOT part of GNU Emacs.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;; early-init.el requires emacs 27
;; based in part on:
;; https://github.com/MatthewZMD/.emacs.d/blob/master/early-init.el
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(setenv "LSP_USE_PLISTS" "true")

;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold 100000000) ;; 100MB

;; default is 4k.  some ls resp in 800k-3M range
(setq read-process-output-max (* 1024 1024)) ;; 1MB

;; disable package.el at startup for straight
(setq package-enable-at-startup nil)

;; UnsetFNHA
(defvar file-name-handler-alist-original file-name-handler-alist)
(setq file-name-handler-alist nil)

;; UnsetSRF
(setq site-run-file nil)

;; early interface config
(when (display-graphic-p)
    (scroll-bar-mode -1)
    (fringe-mode 0)
    (tool-bar-mode -1))
(menu-bar-mode -1)


(provide 'early-init)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; early-init.el ends here