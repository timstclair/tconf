(provide 'log-file-mode)

(require 'ansi-color)
(defun display-ansi-colors ()
  (interactive)
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))

(define-derived-mode log-file-mode read-only-mode "log-file"
  "Major mode for inspecting log files."

  ;; Ignore whitespace.
  (setq show-trailing-whitespace nil)

  ;; Process ascii colors
  (display-ansi-colors)

  ;; Ignore modifications from display-ansi-colors.
  (not-modified))

;; autoload for .log files
(add-to-list 'auto-mode-alist (cons "\\.log\\'" 'log-file-mode))
