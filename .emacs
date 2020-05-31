;;;; ivan-specific start

;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;'(default ((t (:family "DejaVu Sans Mono" :foundry "unknown" :slant normal :weight normal :height 143 :width normal)))))

(tool-bar-mode -1)
(auto-fill-mode -1)
(turn-off-auto-fill)
(add-hook 'scheme-mode-hook 'turn-off-auto-fill)
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

;;;; ivan-specific end

(setq load-path (append (list "~/.emacs.d/lisp") load-path))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;         MIT-scheme config                        ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; This is the place where you have installed scheme. Be sure to set
;; this to an appropriate value!!!
(setq scheme-root "/usr/lib/x86_64-linux-gnu/mit-scheme")

(setq scheme-program-name
      (concat
       "/usr/bin/mit-scheme-x86-64 "
       "--library " scheme-root " "
       "--band " scheme-root "/all.com "
       "-heap 10000"))

;; generic scheme completeion
(require 'scheme-complete)
(autoload 'scheme-smart-complete "scheme-complete" nil t)
(autoload 'scheme-get-current-symbol-info "scheme-complete" nil t)
(setq lisp-indent-function 'scheme-smart-indent-function)

;; mit-scheme documentation
(require 'mit-scheme-doc)

;; Special keys in scheme mode. Use <tab> to indent scheme code to the
;; proper level, and use M-. to view mit-scheme-documentation for any
;; symbol. 
(eval-after-load  
 'scheme
 '(define-key scheme-mode-map "\t" 'scheme-complete-or-indent))

(eval-after-load  
 'cmuscheme
 '(define-key inferior-scheme-mode-map "\t" 'scheme-complete-or-indent))

(eval-after-load  
 'scheme
 '(define-key scheme-mode-map (kbd "M-.") 'mit-scheme-doc-lookup))

(eval-after-load  
 'cmuscheme
 '(define-key inferior-scheme-mode-map (kbd "M-.")
    'mit-scheme-doc-lookup))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;         Flash Paren Mode                         ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "flash-paren")
(flash-paren-mode 1)
(setq flash-paren-delay 0.7)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;         Firefox Style Font Resizing              ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar rlm-default-font-size 160)
(defvar rlm-font-size 
  rlm-default-font-size)

(defun change-font-size (num)
  (setq rlm-font-size (+ rlm-font-size num))
  (message (number-to-string rlm-font-size))
  (set-face-attribute 'default nil 
		      :height rlm-font-size))

(defun font-increase () 
  (interactive)
  (change-font-size 3))

(defun font-decrease () 
  (interactive)
  (change-font-size -3))

(defun font-restore ()
  (interactive)
  (setq rlm-font-size rlm-default-font-size)
  (change-font-size 0))

;; Same bindings as Firefox
(global-set-key (kbd "C-+") 'font-increase)
(global-set-key (kbd "C--") 'font-decrease)
(global-set-key (kbd "C-=") 'font-restore)

(change-font-size 0)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;         Firefox Style Fullscreen                 ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  From http://www.emacswiki.org/emacs/FullScreen
(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter 
     nil 'fullscreen
     (if (equal 'fullboth current-value)
	 (if (boundp 'old-fullscreen) old-fullscreen nil)
       (progn (setq old-fullscreen current-value)
	      'fullboth)))))
;; again, same bindings as firefox
(global-set-key [f11] 'toggle-fullscreen)

;; start in fullscreen mode
;;(toggle-fullscreen)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;         Print a Buffer to PDF  (C-c C-p)         ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun print-to-pdf ()
  (interactive)
  (ps-spool-buffer-with-faces)
  (switch-to-buffer "*PostScript*")
  (write-file "/tmp/tmp.ps")
  (kill-buffer "tmp.ps")
  (setq pdf-target-name (concat "/tmp/" (buffer-name) ".pdf"))
  (setq cmd (concat "ps2pdf14 /tmp/tmp.ps " "\"" pdf-target-name "\""))
  (shell-command cmd)
  (shell-command "rm /tmp/tmp.ps")
  (message (concat "Saved to:  " pdf-target-name)))

(global-set-key (kbd "C-c C-p") 'print-to-pdf)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;         Miscellaneous Settings                   ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq x-select-enable-clipboard 't)
(setq auto-mode-alist (cons '("README" . text-mode) auto-mode-alist))
;; activate auto-fill-mode for various other modes
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'scheme-mode-hook 'turn-on-auto-fill)
(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying \"Active processes exist\" query when you quit Emacs."
  (flet ((process-list ())) ad-do-it))
(setq-default ispell-program-name "aspell")

(global-linum-mode 1) ; always show line numbers
(setq c-default-style "linux" c-basic-offset 4)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.savesemacs/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
