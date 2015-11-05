;; GUI style configuration.

;; Load current theme
(load-file "~/.tconf/themes/current-theme/emacs.el")

(global-hl-line-mode 1)           ;; highlight the current line

(cond ((member "Source Code Pro" (font-family-list))
       (set-face-attribute 'default nil :font "Source Code Pro-12"))
      ((member "Liberation Mono" (font-family-list))
       (set-face-attribute 'default nil :font "Liberation Mono-12")))
