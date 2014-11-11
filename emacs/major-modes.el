;;
;; Customizations for major modes
;;
(provide 'major-modes)

;;
;; asm-mode
;;

;; Override indentation of assembler commands to have 0 indentation
(defun asm-calculate-indentation-override ()
  (or
   ;; Flush specific assembler commands to the left margin.
   (and (looking-at "\\.globl") 0)
   (and (looking-at "\\.section") 0)
   (asm-calculate-indentation-original)))
(eval-after-load "asm-mode"
  '(progn
     (fset 'asm-calculate-indentation-original (symbol-function 'asm-calculate-indentation))
     (fset 'asm-calculate-indentation 'asm-calculate-indentation-override)))

;; Set asm-mode comment character to the @ (for ARM)
(setq-default asm-comment-char ?@)

;; Cleanup whitespace on save in asm-mode
(add-hook 'asm-mode-hook
          (lambda ()
            (add-hook 'before-save-hook
                      'whitespace-cleanup
                      nil
                      1)))
