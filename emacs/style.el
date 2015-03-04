;; GUI style configuration.

;; Mode-line (status bar)
(set-face-attribute 'mode-line nil
                    :foreground "#ffffff"
                    :background "#009688"
                    :box '(:line-width -1 :color "grey40" :style nil))
(set-face-attribute 'mode-line-inactive nil
                    :foreground "white"
                    :background "gray60"
                    :box '(:line-width -1 :color "grey40" :style nil))

;; Highlighted region
(set-face-attribute 'region nil
                    :foreground "gray10"
                    :background "#ffc400")

;; Highlighted line
(global-hl-line-mode 1)           ;; highlight the current line
(set-face-attribute 'hl-line nil
                    :background "gray95")

(when (member "Liberation Mono" (font-family-list))
  (set-face-attribute 'default nil :font "Liberation Mono-11"))
