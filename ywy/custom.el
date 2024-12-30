(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(comment-style 'extra-line)
 '(custom-enabled-themes '(ardent122))
 '(custom-safe-themes
   '("5f643f6d62cd67e9ed3b7a8503b0100d8ba642798e65a5dcef09218d457ec710" default))
 '(delete-active-region t)
 '(display-table-vertical-border '(9475 vertical-border))
 '(dtrt-indent-global-mode t)
 '(dtrt-indent-min-offset 1)
 '(dtrt-indent-mode t nil (dtrt-indent))
 '(file-cache-completion-ignore-case t)
 '(global-hl-line-mode t)
 '(global-visual-line-mode t)
 '(isearch-allow-scroll t)
 '(kill-ring-max 10)
 '(kill-whole-line t)
 '(linum-format "% 2d")
 '(mode-require-final-newline nil)
 '(package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
	 ("melpa" . "https://melpa.org/packages/")))
 '(package-selected-packages
   '(popper diminish which-key vterm no-littering flycheck elpy dtrt-indent))
 '(quote (custom-enabled-themes '(ardent122)))
 '(save-interprogram-paste-before-kill t)
 '(search-ring-max 8)
 '(show-paren-ring-bell-on-mismatch nil)
 '(tab-always-indent nil)
 '(tab-bar-mode t)
 '(tab-bar-new-tab-choice t)
 '(tab-bar-show 1)
 '(term-file-aliases
   '(("apollo" . "vt100")
	 ("vt102" . "vt100")
	 ("vt125" . "vt100")
	 ("vt201" . "vt200")
	 ("vt220" . "vt200")
	 ("vt240" . "vt200")
	 ("vt300" . "vt200")
	 ("vt320" . "vt200")
	 ("vt400" . "vt200")
	 ("vt420" . "vt200")
	 ("alacritty" . "xterm")
	 ("foot" . "xterm")
	 ("contour" . "xterm")
	 ("ms-terminal" . "xterm")))
 '(tetris-use-glyphs t)
 '(warning-suppress-types
   '(((python python-shell-completion-native-turn-on-maybe))
	 ((python python-shell-completion-native-turn-on-maybe))
	 (comp)))
 '(xterm-mouse-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#111E33" :foreground "#c6cbd7" :inverse-video nil :box nil :strike-through nil :extend nil :overline nil :underline nil :slant normal :weight normal :height 1 :width normal :foundry "default" :family "default"))))
 '(fill-column-indicator ((t (:inherit mode-line :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal))))
 '(header-line ((t (:inherit mode-line :inverse-video nil :underline nil))))
 '(tab-bar ((t (:inherit header-line))))
 '(tab-bar-tab ((t (:inherit (tab-line-tab tab-line-tab-current) :foreground "#f1f4fb" :underline "#f6c7ff" :weight bold))))
 '(tab-bar-tab-inactive ((t (:inherit tab-bar))))
 '(tab-line ((t (:inherit mode-line :height 0.9))))
 '(tab-line-close-highlight ((t (:foreground "highlight"))))
 '(tab-line-tab ((t (:inherit mode-line))))
 '(tab-line-tab-current ((t (:inherit (tab-line-tab header-line) :foreground "#f1f4fb" :underline t :weight bold))))
 '(tab-line-tab-inactive ((t (:inherit mode-line-inactive))))
 '(warning ((t (:foreground "DarkOrange" :weight extra-bold)))))
