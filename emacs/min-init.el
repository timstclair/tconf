;;
;; Fast initialization with minimal customization
;;

;; TODO: Refactor these settings to a common location

;; UI settings
(menu-bar-mode 0)                   ;; disable the menubaar
(when window-system
    (tool-bar-mode 0)               ;; disable the toolbar
    (scroll-bar-mode 0))            ;; disable scrollbars
(setq inhibit-startup-screen t)     ;; don't show welcome screen
(setq inhibit-splash-screen t)      ;; don't show splash screen
(setq initial-scratch-message "")   ;; empty initial scratch buffer

;; OSX Compatability
(when (string= system-type "darwin")
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (prefer-coding-system 'utf-8))

;; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; Show bad ws
(setq-default show-trailing-whitespace t)

;; Column numbers
(column-number-mode 1)

;; Require a final newline in a file, to avoid confusing some tools
(setq require-final-newline t)

;; Use y-n instead of yes-no for prompts
(defalias 'yes-or-no-p 'y-or-n-p)

;; Settings commonly used from the commandline
(setq ediff-split-window-function 'split-window-horizontally)

;; Ediff command line option
(defun command-line-diff (switch)
  (let ((file1 (pop command-line-args-left))
        (file2 (pop command-line-args-left)))
    (ediff file1 file2)))
(defun command-line-merge (switch)
  (let ((file1 (pop command-line-args-left))
        (file2 (pop command-line-args-left)))
    (progn
      (ediff-merge file1 file2)
      (add-hook 'ediff-quit-hook 'save-buffers-kill-terminal))))
(add-to-list 'command-switch-alist '("-diff" . command-line-diff))
(add-to-list 'command-switch-alist '("-merge" . command-line-merge))
