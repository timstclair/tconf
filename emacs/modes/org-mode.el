;; Org-mode settings

(setq
  org-startup-indented t
  org-startup-folded nil
  org-directory "~/notes"
  org-blank-before-new-entry '((heading . nil)
                               (plain-list-item . nil))
  org-cycle-level-faces nil
  org-fontify-done-headline t)  ;; apply org-headline-done font

(setq org-todo-keywords
  '((sequence "TODO(t)" "STARTED(s)" "DONE(d)")
    (sequence "BLOCKED(b@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)")
    (sequence "PR-REVIEW(p)" "PR-TODO" "PR-QUEUE(q)" "|")
    (sequence "REVIEW(r)" "REVIEW-WAIT(w)" "|")))
(setq org-todo-keyword-faces
  '(("HOLD" (:weight light))
    ("CANCELLED" (:weight light))
    ("BLOCKED" (:inherit warning))
    ("PR-TODO" (:inherit warning))
    ("PR-QUEUE" (:inherit org-done))
    ("REVIEW" (:inherit warning))
    ("STARTED" (:inherit warning))))

(custom-set-faces
  '(org-headline-done ((t (:foreground nil :strike-through t))))
  '(org-level-2 ((t (:inherit nil :height 1.0 :weight bold :foreground nil))))
  '(org-level-3 ((t (:inherit nil :height 1.0 :weight medium :foreground nil))))
  '(org-level-4 ((t (:inherit nil :height 1.0 :weight medium :foreground nil))))
  '(org-level-5 ((t (:inherit nil :height 1.0 :weight medium :foreground nil))))
  '(org-level-6 ((t (:inherit nil :height 1.0 :weight medium :foreground nil))))
  '(org-level-7 ((t (:inherit nil :height 1.0 :weight medium :foreground nil))))
  '(org-level-8 ((t (:inherit nil :height 1.0 :weight medium :foreground nil))))
  '(org-level-9 ((t (:inherit nil :height 1.0 :weight medium :foreground nil)))))

;; Custom sparse-tree commands
(setq org-agenda-custom-commands
  '(("A" occur-tree "TODO|STARTED|BLOCKED|PR-REVIEW|PR-TODO|PR-QUEUE|REVIEW|REVIEW-WAIT")))
