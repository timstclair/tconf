;; GUI style configuration.

;; Mode-line (status bar)
(set-face-attribute 'mode-line nil
                    :foreground "gray80"
                    :background "#009688"
                    :box '(:line-width -1 :color "grey40" :style nil))
(set-face-attribute 'mode-line-inactive nil
                    :foreground "gray60"
                    :background "gray25"
                    :box '(:line-width -1 :color "grey40" :style nil))

;; Highlighted region
(set-face-attribute 'region nil
                    :foreground "gray10"
                    :background "gray80")

;; Highlighted line
(set-face-attribute 'hl-line nil
                    :background "gray95")