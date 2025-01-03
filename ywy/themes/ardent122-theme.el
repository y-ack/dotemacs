(deftheme ardent122
  "Created 2021-03-07.")

(custom-theme-set-variables
 'ardent122
 '(linum-format "% 2d"))

(custom-theme-set-faces
 'ardent122
 '(query-replace ((t (:inherit (isearch)))))
 '(next-error ((t (:foreground "#d77175"))))
 '(match ((t (:inherit highlight))))
 '(lazy-highlight ((t (:background "paleturquoise"))))
 '(isearch-fail ((t (:background "#d77175"))))
 '(isearch ((t (:inherit region))))
 '(mode-line-filename-face ((t (:inherit mode-line-face :foreground "#f1f4fb" :weight bold))))
 '(mode-line-folder-face ((t (:inherit mode-line-face :foreground "#b0b5c1"))))
 '(mode-line-80col-face ((t (:inherit mode-line-position-face :background "#3a1100"))))
 '(mode-line-minor-mode-face ((t (:height 110 :foreground "gray40" :inherit (mode-line-mode-face)))))
 '(mode-line-mode-face ((t (:foreground "gray80" :inherit (mode-line-face)))))
 '(mode-line-read-only-face ((t (:inherit mode-line-face :foreground "#6c6cc4"))))
 '(mode-line-modified-face ((t (:inherit mode-line-face :foreground "#d8a1ef"))))
 '(mode-line-inactive ((t (:weight light :foreground "#b0b5c1" :background "#182439" :inherit mode-line))))
 '(mode-line-highlight ((t (:background "#875000" :foreground "#b0b5c1" :inherit mode-line))))
 '(mode-line-emphasis ((t (:weight bold))))
 '(mode-line-buffer-id ((t (:weight bold))))
 '(mode-line ((t (:background "#212c41" :foreground "#b0b5c1"))))
 '(tooltip ((t (:inherit variable-pitch :background "#182439" :foreground "#eeeeee" :box (:line-width (1 . 1) :color "#182439")))))
 '(header-line ((t (:underline (:color foreground-color :style line) :inverse-video nil :inherit (mode-line)))))
 '(fringe ((t (:inherit default))))
 '(link-visited ((t (:inherit link :foreground "#d8a1ef"))))
 '(link ((t (:foreground "#4e94ce" :underline t))))
 '(button ((t (:foreground "#fdffff" :background "#9f6bb6" :inherit link))))
 '(font-lock-warning-face ((t (:inherit error :foreground "#cd9731"))))
 '(font-lock-variable-name-face ((t (:foreground "#e3e7ef"))))
 '(font-lock-type-face ((t (:foreground "#b7d9ff"))))
 '(font-lock-string-face ((t (:foreground "#ffd998"))))
 '(font-lock-regexp-grouping-construct ((t (:inherit :bold :foreground "#9da3b1"))))
 '(font-lock-regexp-grouping-backslash ((t (:inherit :bold :foreground "#ffd6ff"))))
 '(font-lock-preprocessor-face ((t (:inherit (font-lock-builtin-face)))))
 '(font-lock-negation-char-face ((t (:foreground "#9da3b1"))))
 '(font-lock-keyword-face ((t (:foreground "#f6c7ff"))))
 '(font-lock-function-name-face ((t (:foreground "#b7d9ff"))))
 '(font-lock-doc-face ((t (:inherit font-lock-comment-face))))
 '(font-lock-constant-face ((t (:foreground "#93fcc4"))))
 '(font-lock-comment-face ((t (:foreground "#824140" :slant italic :weight bold))))
 '(font-lock-comment-delimiter-face ((t (:inherit font-lock-comment-face))))
 '(font-lock-builtin-face ((t (:foreground "#f6c7ff"))))
 '(trailing-whitespace ((t (:background "#e3e4e2"))))
 '(secondary-selection ((t (:inherit region :extend t))))
 '(shadow ((t (:foreground "#bbbbbb"))))
 '(region ((t (:extend t :background "#5c81bd"))))
 '(highlight ((t (:inherit region))))
 '(minibuffer-prompt ((t (:foreground "#f1f4fb"))))
 '(homoglyph ((t (:inherit escape-glyph))))
 '(escape-glyph ((t (:foreground "#9da3b1"))))
 '(variable-pitch ((((type w32)) (:foundry "outline" :family "Arial")) (t (:family "Sans Serif"))))
 '(fixed-pitch ((t (:family "Monospace"))))
 '(cursor ((((background light)) (:background "black")) (((background dark)) (:background "white"))))
 '(line-number ((t (:inherit (shadow default) :background "#111e33" :foreground "#565e71"))))
 '(line-number-current-line ((t (:inherit line-number :foreground "#787f90"))))
 '(line-number-major-tick ((((class color grayscale) (background light)) (:bold t :background "grey85")) (((class color grayscale) (background dark)) (:bold t :background "grey75")) (t (:inherit (line-number)))))
 '(line-number-minor-tick ((((class color grayscale) (background light)) (:bold t :background "grey95")) (((class color grayscale) (background dark)) (:bold t :background "grey55")) (t (:inherit (line-number)))))
 '(hl-line ((t (:extend t :background "#182439"))))
 '(vertical-border ((t (:foreground "#2c364a"))))
 '(default ((t (:inherit nil :extend nil :stipple nil :background "unspecified-bg" :foreground "#c6cbd7" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 1 :width normal :foundry "default" :family "default"))))
 '(flymake-error ((t (:inherit error :foreground "#d77175"))))
 '(flymake-warning ((t (:inherit warning :foreground "#4d9e4d"))))
 '(flymake-note ((t (:inherit \#008000)))))

(provide-theme 'ardent122)
