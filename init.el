(defvar better-gc-cons-threshold 134217728 ; 128mb
  "The default value to use for `gc-cons-threshold'.")

(defun better-gc ()
  (setq gc-cons-threshold better-gc-cons-threshold)
  (setq file-name-handler-alist file-name-handler-alist-original)
  (makunbound 'file-name-handler-alist-original))

(add-hook 'emacs-startup-hook #'better-gc)

;; startup time message
(defun ywy/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                     (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'ywy/display-startup-time)

(add-to-list 'load-path "~/.emacs.d/ywy")
;(add-to-list 'load-path "~/.emacs.d/ywy/features")
;(add-to-list 'load-path "~/.emacs.d/ywy/modes")
(add-to-list 'load-path "~/.emacs.d/ywy/themes")
(require 'ardent122-theme)
(require 'ywy-preferences)


;; backup files
(use-package no-littering)

;; place auto save files in the same path as it uses for sessions
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; key help
(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode 1)
  (setq which-key-idle-delay 1))

;; shell replacement
(use-package vterm
  :defer t
  :commands vterm
  :config
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")  ;; Set this to shell prompt
  (setq vterm-max-scrollback 10000))


(require 'ywy-popper)

(setq comp-deferred-compilation t)

(defgroup display-table
  '((display-table-wrap custom-variable)
	(display-table-vertical-border custom-variable)
	(display-table-truncation custom-variable))
  "Standard display table glyphs")

(defmacro defcustom-table-slot (varname slot doc default)
  `(defcustom ,varname
	 ,default
	 ,doc
	 :group 'display-table
	 :type '(list character face)
	 :set (lambda (sym value)
			(set-display-table-slot standard-display-table ,slot
									(make-glyph-code (car value) (car (cdr value)))))
	 :get (lambda (sym)
			(let ((glyph (display-table-slot standard-display-table
											 ,slot)))
			  (list (glyph-char glyph) (or
										(glyph-face glyph) 'default))))))

(defvar display-table-vertical-border '(?\| vertical-border))
(defcustom-table-slot display-table-vertical-border
					  'vertical-border
					  "Glyph to use for the vertical borders separating
windows"
					  '(?\| vertical-border))
(defvar display-table-wrap '(?\\ default))
(defcustom-table-slot display-table-wrap 'wrap
					  "Glyph to use for line wrap symbols"
					  '(?\\ default))
(defvar display-table-truncation '(?\$ default))
(defcustom-table-slot display-table-truncation 'truncation
					  "Glyph used to indicate lines that extend offscreen"
					  '(?\$ default))

;; global variable config
(setq echo-keystrokes 0.1               ; Show keystrokes asap
      inhibit-startup-screen t          ; No splash screen please
      initial-scratch-message nil       ; Clean scratch buffer
      ring-bell-function 'ignore        ; Quiet
      gc-cons-threshold 20000000        ; large gc threshold during init
      read-process-output-max (* 1024 1024))  ; 1mb (suggested by lsp)
(setq-default tab-width 4                       ; Smaller tabs
              fill-column 79                    ; Maximum line width
              truncate-lines t                  ; Don't fold lines
              indent-tabs-mode t                ; Use tabs
              global-hl-line-mode t             ; highlight current line
              split-width-threshold 160         ; Split vertically by default
              split-height-threshold nil        ; Split vertically by default
              auto-fill-function 'do-auto-fill) ; Auto-fill-mode everywhere

;; wsl-copy
(defun wsl-copy (start end)
  (interactive "r")
  (shell-command-on-region start end "clip.exe")
  (deactivate-mark))

;; wsl-paste
(defun wsl-paste ()	
  (interactive)		
  (let ((clipboard
		 (shell-command-to-string "powershell.exe -command 'Get-Clipboard'
2> /dev/null")))
	(setq clipboard (replace-regexp-in-string "\r" "" clipboard))
	;; Remove Windows ^M characters
	(setq clipboard (substring clipboard 0 -1))
	;;Remove newline added by Powershell
	(insert clipboard)))

(global-set-key (kbd "C-c C-w") 'wsl-copy)
(global-set-key (kbd "C-c C-e") 'wsl-paste)


;; packages
;(use-package magit)

(use-package paren)
(use-package flycheck
  :defer t)

(use-package flymake
  :defer t)


;;; dtrt-indent: adopt foreign indentation style
(use-package dtrt-indent)

;; better highlighting with tree-sitter
;; (use-package tsc :defer t
;;   :straight (tsc :host github
;; 				 :repo "ubolonton/emacs-tree-sitter"
;; 				 :files ("core/*.el")))

;; (use-package tree-sitter :defer t
;;   :straight (tree-sitter :host github
;; 					     :repo "ubolonton/emacs-tree-sitter"
;; 						 :files ("lisp/*.el" "src" "Cargo.toml" "Cargo.lock"))
;;   :hook ((after-init . global-tree-sitter-mode)
;; 	     ((python-mode js-mode rust-mode) . tree-sitter-hl-mode)))

;; (use-package tree-sitter-langs
;;   :straight (tree-sitter-langs :host github
;; 							   :repo "ubolonton/emacs-tree-sitter"
;; 							   :files ("langs/*.el" "langs/queries")))
;;(straight-use-package 'tree-sitter-langs)

;; tab bar: show after creating tabs
(setq tab-bar-show t)
;; C-x t 2 == tab-new
;; C-x t 0 == tab-close
;; C-x t o / C-TAB == next tab

;; company: completion
(use-package company
  :config
  (setq company-idle-delay 0
        company-echo-delay 0
        company-dabbrev-downcase nil
        company-minimum-prefix-length 2
        company-selection-wrap-around t
        company-transformers '(company-sort-by-occurrence
                               company-sort-by-backend-importance)
		company-occurrence-weight-function'company-occurrence-prefer-any-closest
		company-show-quick-access t)
  )

;(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'after-init-hook 'company-tng-mode)
(setq tab-always-indent t)

(eval-after-load 'company
	'(push 'company-capf company-backends))
;(company-tng-configure-default) ; tab-n-go

;(push 'company-capf company-backends)

(setq lsp-completion-provider :capf)
;; LANGUAGES TO ENABLE COMPLETION FOR
; (all of them)
; (add-hook 'c-mode-hook 'company-mode)
; (add-hook 'c++-mode-hook 'company-mode)
; python enabled by elpy

;;; python
(use-package elpy
  :ensure t
  :defer t
  :init
    (advice-add 'python-mode :before 'elpy-enable))
;(add-hook 'python-mode 'elpy-enable)
;(add-hook 'python-mode 'elpy-mode)
(add-hook 'python-mode-hook (lambda () (if (buffer-file-name)
							               (flymake-mode))))
;(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)


(define-key function-key-map "\e[1~" [home])
(define-key function-key-map "\e[4~" [end])
;; you probably dont need any of these key defs since term file alias whatever
;; is set but maybe
;;; keys??
;; (define-key function-key-map "\e[1;3D" (kbd "H-M-A-j"))
;; (define-key function-key-map "\e[1;3C" (kbd "H-M-A-l"))
;; (define-key function-key-map "\e[1;5D" (kbd "<C-left>"))
;; (define-key function-key-map "\e[1;5C" (kbd "<C-right>"))
;; (define-key function-key-map "\e[1;5A" (kbd "<C-up>"))
;; (define-key function-key-map "\e[1;5B" (kbd "<C-down>"))
;; (define-key function-key-map "\e[1;7D" (kbd "H-A-<left>"))
;; (define-key function-key-map "\e[1;7C" (kbd "H-A-<right>"))
;; (define-key function-key-map "\e[1;7A" (kbd "H-A-<up>"))
;; (define-key function-key-map "\e[1;7B" (kbd "H-A-<down>"))
;; (define-key function-key-map "\e[27;5;73~" (kbd "H-i"))
;; (define-key function-key-map "\e[27;7;73~" (kbd "H-M-i"))
;; (define-key function-key-map "\e[27;5;77~" (kbd "H-m"))
;; (define-key function-key-map "\e[27;5;91~" (kbd "H-["))

;; ;; C-S-
;; (define-key function-key-map "\e[27;6;65~" (kbd "H-A-a"))
;; (define-key function-key-map "\e[27;6;66~" (kbd "H-A-b"))
;; (define-key function-key-map "\e[27;6;67~" (kbd "H-A-c"))
;; (define-key function-key-map "\e[27;6;68~" (kbd "H-A-d"))
;; (define-key function-key-map "\e[27;6;69~" (kbd "H-A-e"))
;; (define-key function-key-map "\e[27;6;70~" (kbd "H-A-f"))
;; (define-key function-key-map "\e[27;6;71~" (kbd "H-A-g"))
;; (define-key function-key-map "\e[27;6;72~" (kbd "H-A-h"))
;; (define-key function-key-map "\e[27;6;73~" (kbd "H-A-i"))
;; (define-key function-key-map "\e[27;6;74~" (kbd "H-A-j"))
;; (define-key function-key-map "\e[27;6;75~" (kbd "H-A-k"))
;; (define-key function-key-map "\e[27;6;76~" (kbd "H-A-l"))
;; (define-key function-key-map "\e[27;6;77~" (kbd "H-A-m"))
;; (define-key function-key-map "\e[27;6;78~" (kbd "H-A-n"))
;; (define-key function-key-map "\e[27;6;79~" (kbd "H-A-o"))
;; (define-key function-key-map "\e[27;6;80~" (kbd "H-A-p"))
;; (define-key function-key-map "\e[27;6;81~" (kbd "H-A-q"))
;; (define-key function-key-map "\e[27;6;82~" (kbd "H-A-r"))
;; (define-key function-key-map "\e[27;6;83~" (kbd "H-A-s"))
;; (define-key function-key-map "\e[27;6;84~" (kbd "H-A-t"))
;; (define-key function-key-map "\e[27;6;85~" (kbd "H-A-u"))
;; (define-key function-key-map "\e[27;6;86~" (kbd "H-A-v"))
;; (define-key function-key-map "\e[27;6;87~" (kbd "H-A-w"))
;; (define-key function-key-map "\e[27;6;88~" (kbd "H-A-x"))
;; (define-key function-key-map "\e[27;6;89~" (kbd "H-A-y"))
;; (define-key function-key-map "\e[27;6;90~" (kbd "H-A-z"))
;; ;; C-M-S-
;; (define-key function-key-map "\e[27;8;65~" (kbd "H-M-A-a"))
;; (define-key function-key-map "\e[27;8;66~" (kbd "H-M-A-b"))
;; (define-key function-key-map "\e[27;8;67~" (kbd "H-M-A-c"))
;; (define-key function-key-map "\e[27;8;68~" (kbd "H-M-A-d"))
;; (define-key function-key-map "\e[27;8;69~" (kbd "H-M-A-e"))
;; (define-key function-key-map "\e[27;8;70~" (kbd "H-M-A-f"))
;; (define-key function-key-map "\e[27;8;71~" (kbd "H-M-A-g"))
;; (define-key function-key-map "\e[27;8;72~" (kbd "H-M-A-h"))
;; (define-key function-key-map "\e[27;8;73~" (kbd "H-M-A-i"))
;; (define-key function-key-map "\e[27;8;74~" (kbd "H-M-A-j"))
;; (define-key function-key-map "\e[27;8;75~" (kbd "H-M-A-k"))
;; (define-key function-key-map "\e[27;8;76~" (kbd "H-M-A-l"))
;; (define-key function-key-map "\e[27;8;77~" (kbd "H-M-A-m"))
;; (define-key function-key-map "\e[27;8;78~" (kbd "H-M-A-n"))
;; (define-key function-key-map "\e[27;8;79~" (kbd "H-M-A-o"))
;; (define-key function-key-map "\e[27;8;80~" (kbd "H-M-A-p"))
;; (define-key function-key-map "\e[27;8;81~" (kbd "H-M-A-q"))
;; (define-key function-key-map "\e[27;8;82~" (kbd "H-M-A-r"))
;; (define-key function-key-map "\e[27;8;83~" (kbd "H-M-A-s"))
;; (define-key function-key-map "\e[27;8;84~" (kbd "H-M-A-t"))
;; (define-key function-key-map "\e[27;8;85~" (kbd "H-M-A-u"))
;; (define-key function-key-map "\e[27;8;86~" (kbd "H-M-A-v"))
;; (define-key function-key-map "\e[27;8;87~" (kbd "H-M-A-w"))
;; (define-key function-key-map "\e[27;8;88~" (kbd "H-M-A-x"))
;; (define-key function-key-map "\e[27;8;89~" (kbd "H-M-A-y"))
;; (define-key function-key-map "\e[27;8;90~" (kbd "H-M-A-z"))
(global-set-key [(control j)] 'backward-char)
(global-set-key [(control l)] 'forward-char)
(global-set-key [(control meta j)] 'backward-word)
(global-set-key [(control meta l)] 'forward-word)
(global-set-key (kbd "H-M-A-j") 'beginning-of-line) ;super doesn't work yet
(global-set-key (kbd "H-M-A-l") 'end-of-line)
(global-set-key (kbd "H-i") 'previous-line)
;(global-set-key (kbd "TAB") 'indent-according-to-mode)

(global-set-key (kbd "C-k") 'next-line)
(global-set-key (kbd "H-M-i") 'backward-paragraph)
(global-set-key (kbd "C-M-k") 'forward-paragraph)
(global-set-key (kbd "H-M-A-i") 'previous-line)
(global-set-key (kbd "H-M-A-k") 'next-line)
(global-set-key [(control a)] 'backward-delete-char)
(global-set-key [(control d)] 'delete-char)
(global-set-key [(control meta a)] 'backward-kill-word)
(global-set-key [(control meta d)] 'kill-word)
(global-set-key (kbd "H-M-A-a") 'backward-kill-sexp)
(global-set-key (kbd "H-M-A-d") 'kill-sexp)
(global-set-key [(control w)] 'kill-region)
(global-set-key [(control e)] 'yank)
(global-set-key [(control s)] 'save-buffer)
(global-set-key (kbd "H-A-s") 'write-file)
(global-set-key [(control n)] 'goto-line)
(global-set-key (kbd "C-M-f") 'isearch-backward)
(global-set-key (kbd "C-f") 'isearch-forward)
(define-key isearch-mode-map (kbd "C-M-f") 'isearch-repeat-backward)
(define-key isearch-mode-map (kbd "C-f") 'isearch-repeat-forward)
(global-set-key [(control r)] 'replace-string)
(global-set-key (kbd "C-p") 'recenter-top-bottom)
(global-set-key (kbd "C-x <deletechar>") 'just-one-space)

(global-set-key (kbd "H-A-<up>") 'windmove-up)
(global-set-key (kbd "H-A-<down>") 'windmove-down)
(global-set-key (kbd "H-A-<left>") 'windmove-left)
(global-set-key (kbd "H-A-<right>") 'windmove-right)

;; org
(setq org-src-fontify-natively t
      org-src-tab-acts-natively t
      org-confirm-babel-evaluate nil
      org-edit-src-content-indentation 0)

(defun tidy ()
  "Ident, untabify and unwhitespacify current buffer, or region if active."
  (interactive)
  (let ((beg (if (region-active-p) (region-beginning) (point-min)))
        (end (if (region-active-p) (region-end) (point-max))))
    (indent-region beg end)
    (whitespace-cleanup)))

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)

;; Extra mode line faces
(make-face 'mode-line-read-only-face)
(make-face 'mode-line-modified-face)
(make-face 'mode-line-folder-face)
(make-face 'mode-line-filename-face)
(make-face 'mode-line-position-face)
(make-face 'mode-line-mode-face)
(make-face 'mode-line-minor-mode-face)
(make-face 'mode-line-process-face)
(make-face 'mode-line-80col-face)

;; Mode line setup
(defvar mode-line-cleaner-alist
  `((auto-complete-mode . "")
	(yas/minor-mode . "y")
	(paredit-mode . "")
	(eldoc-mode . "")
	(abbrev-mode . "")
	;; Major modes
	(lisp-interaction-mode . "λ")
	(hi-lock-mode . "")
	(python-mode . "Py")
	(emacs-lisp-mode . "EL")
	    (nxhtml-mode . "nx")))

(setq-default
 mode-line-format
 '(
   ;; directory and buffer/file name
   (:propertize (:eval (shorten-directory default-directory 20))
				face mode-line-folder-face)
   (:eval (cond (buffer-read-only
				 (propertize "%b" 'face 'mode-line-read-only-face))
				((buffer-modified-p)
				 (propertize "%b" 'face 'mode-line-modified-face))
				(t (propertize "%b" 'face 'mode-line-filename-face))))

   ;; Position, including warning for 80 columns
   (:propertize "%4l:" face mode-line-position-face)
   (:eval (propertize "%02c" 'face (if (>= (current-column) 80)
									   'mode-line-80col-face
									 'mode-line-position-face)))
   ;; mode indicators: vc, recursive edit, major mode, minor modes, process,	
   (vc-mode vc-mode)
   "  %["
   (:propertize mode-name face mode-line-mode-face)
   "%] "
   (:eval (propertize (format-mode-line minor-mode-alist)
					  'face 'mode-line-minor-mode-face))
   (:propertize mode-line-process face mode-line-process-face)
   (global-mode-string global-mode-string)
   "    " ))

;; Helper function
(defun shorten-directory (dir max-length)
  "Show up to `max-length' characters of a directory name `dir'."
  (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
		(output ""))
	(when (and path (equal "" (car path))) (setq path (cdr path)))
	(while (and path (< (length output) (- max-length 4)))
	  (setq output (concat (car path) "/" output))
	  (setq path (cdr path)))
	(when path (setq output (concat ".../" output)))
	output))
