;;
;; Fast initialization with minimal customization
;;

;; TODO: Refactor these settings to a common location

;; UI settings
(menu-bar-mode 0)                   ;; disable the menubaar
(tool-bar-mode 0)                   ;; disable the toolbar
(scroll-bar-mode 0)                 ;; disable scrollbars
(setq inhibit-startup-screen t)     ;; don't show welcome screen
(setq inhibit-splash-screen t)      ;; don't show splash screen
(setq initial-scratch-message "")   ;; empty initial scratch buffer

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
