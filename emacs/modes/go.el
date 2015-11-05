;;
;; Go settings
;;

;; SETUP:
;; go {get,install} github.com/rogpeppe/godef  # jump to definition

;; Useful bindings:
;;  C-c C-j  Jump to definition
;;  C-c C-d  Describe symbol

(require 'go-mode)

(add-hook 'go-mode-hook 'flycheck-mode)

(add-hook 'go-mode-hook 'company-mode)
;; (add-hook 'go-mode-hook (lambda ()
;;   (set (make-local-variable 'company-backends) '(company-go))
;;   (company-mode)))

;; Override bindings
(add-hook 'go-mode-hook (lambda ()
  (local-set-key (kbd "M-.") 'godef-jump)))
