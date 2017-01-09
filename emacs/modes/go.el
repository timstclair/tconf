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
  (setq go-command "go"))

(use-package go-guru
  :ensure t
  :config
  (setq go-guru-command "guru")) ;; FIXME - set absolute path
(use-package go-rename
  :ensure t)
