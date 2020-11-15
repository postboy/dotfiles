;;;; ivan-specific start

;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;'(default ((t (:family "DejaVu Sans Mono" :foundry "unknown" :slant normal :weight normal :height 143 :width normal)))))

(setq inhibit-startup-screen t)
(tool-bar-mode -1)
(auto-fill-mode -1)
(turn-off-auto-fill)
(add-hook 'text-mode-hook 'turn-off-auto-fill)

;;(defun sicp ()
  ;;(interactive)
  ;;(load-library "xscheme"))
  ;;(run-scheme))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(blink-cursor-mode nil)
 '(custom-enabled-themes (quote (wombat)))
 '(global-visual-line-mode t))
(put 'narrow-to-region 'disabled nil)

(setq-default fill-column 0)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

;;;; ivan-specific end
