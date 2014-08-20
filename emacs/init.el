;;
;; Global configurations
;;

;; UI settings
(menu-bar-mode 0)                   ;; disable the menubaar
(tool-bar-mode 0)                   ;; disable the toolbar
(scroll-bar-mode 0)                 ;; disable scrollbars
(setq inhibit-startup-screen t)     ;; don't show welcome screen
(setq inhibit-splash-screen t)      ;; don't show splash screen
(setq initial-scratch-message "")   ;; empty initial scratch buffer
(when (display-graphic-p)
  (global-hl-line-mode 1))

;; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; Show bad ws
(require 'whitespace)
(setq show-ws-toggle-show-trailing-whitespace t)
(setq show-ws-toggle-show-tabs t)

;; Column numbers
(column-number-mode 1)

;; For hi-lighted parens
(load-library "paren")

;; Default line length is 100 chars
(setq-default fill-column 100)

;; Require a final newline in a file, to avoid confusing some tools
(setq require-final-newline t)

;; Minibuffer settings
(setq
  enable-recursive-minibuffers nil       ;;  allow mb cmds in the mb
  max-mini-window-height .25             ;;  max 2 lines
  minibuffer-scroll-window nil
  resize-mini-windows nil)

;; Enable some disabled functions
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; Use y-n instead of yes-no for prompts
(defalias 'yes-or-no-p 'y-or-n-p)


;;
;; Keybindings
;;
(global-set-key (kbd "C-x g") 'goto-line)
(global-set-key (kbd "C-c C-f") 'fill-paragraph)  ;; wrap comments to fill-column length
(global-set-key (kbd "C-c r h") 'ff-find-other-file)  ;; toggle .cc and .h files

;;
;; Load plugins
;;
(defun rel-path (relative-path)
  "Return the full path of RELATIVE-PATH, relative to this function call."
  (concat (file-name-directory (or load-file-name buffer-file-name)) relative-path))

;; Load configuration modules.
(load (rel-path "style.el"))
(load (rel-path "major-modes.el"))

;; yasnippets
(add-to-list 'load-path (rel-path "plugins/yasnippet"))
(require 'yasnippet)
(yas-global-mode 1)
(setq yas/prompt-functions '(yas/ido-prompt yas/dropdown-prompt yas/completing-prompt yas/x-prompt yas/no-prompt))

;; js2 mode
(if (>= emacs-major-version 24)
  (progn
    (add-to-list 'load-path (rel-path "plugins/js2-mode"))
    (autoload 'js2-mode "js2-mode" nil t)
    (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
    ;; turn on yas/minor-mode for js2-mode
    (add-hook 'js2-mode 'yas-minor-mode-on)))



;;
;; Create directories for backup / autosave.
;;

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(defvar autosave-dir "~/.emacs.d/autosaves/")
(defun set-autosave-dir (dir)
  "Set the autosave directory location"
  (setq autosave-dir dir)
  (make-directory autosave-dir t))
(defun auto-save-file-name-p (filename)
  (string-match "^#.*#$" (file-name-nondirectory filename)))
(defun make-auto-save-file-name ()
  (concat autosave-dir
   (if buffer-file-name
      (concat "#" (file-name-nondirectory buffer-file-name) "#")
    (expand-file-name
     (concat "#%" (buffer-name) "#")))))

;; Put backup files (ie foo~) in one place too. (The backup-directory-alist
;; list contains regexp=>directory mappings; filenames matching a regexp are
;; backed up in the corresponding directory. Emacs will mkdir it if necessary.)
(defvar backup-dir "~/.emacs.d/backups/")
(defun set-backup-dir (dir)
  "Set the backup directory location"
  (setq backup-dir dir)
  (make-directory backup-dir t)
  (setq backup-directory-alist (list (cons "." backup-dir))))
