;;
;; Go settings
;;

;; SETUP:
;; go {get,install} github.com/rogpeppe/godef  # jump to definition

;; Useful bindings:
;;  C-c C-j  Jump to definition
;;  C-c C-d  Describe symbol

(use-package go-mode
  :ensure t
  :config
  (add-hook 'go-mode-hook 'flycheck-mode)
  (add-hook 'go-mode-hook 'company-mode)
  (add-hook 'before-save-hook 'gofmt-before-save)
  (setq gofmt-command "goimports")
  (bind-keys :map go-mode-map
    ("M-." 'godef-jump)))
