(tool-bar-mode 0)
(scroll-bar-mode 0)
(global-display-line-numbers-mode)
(column-number-mode)
(electric-pair-mode)

(setq-default fill-column 80)
(add-hook 'prog-mode-hook (lambda () (display-fill-column-indicator-mode 1)))

(set-face-attribute 'default nil :font "UbuntuMono Nerd Font Mono-17")
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode)

(require 'evil)
(evil-mode)

(setq evil-insert-state-cursor '((bar . 0) "#ffdd33"))

(add-to-list 'load-path "~/.emacs.d/local/")

(let ((backup-dir "~/.emacs.d/backups/"))
  (when (not (file-directory-p backup-dir))
    (make-directory backup-dir t)))
(setq backup-directory-alist '(("." . "~/.emacs.d/backups/")))

(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))
(add-to-list 'auto-mode-alist '("\\.[b]\\'" . simpc-mode))

(defun my-simpc-mode-hook ()
  (setq-local indent-tabs-mode nil)
  (setq-local tab-width 4))

(add-hook 'simpc-mode-hook 'my-simpc-mode-hook)

(defun my-go-mode-hook ()
  (setq-local tab-width 4))

(add-hook 'go-mode-hook 'my-go-mode-hook)
(add-hook 'makefile-mode-hook 'my-go-mode-hook)

;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(gruber-darker))
 '(custom-safe-themes
   '("7d1c7ea4f3e73402f012b7011fc4be389597922fa67ad4ec417816971bca6f9d"
     "db86c52e18460fe10e750759b9077333f9414ed456dc94473f9cf188b197bc74"
     "e13beeb34b932f309fb2c360a04a460821ca99fe58f69e65557d6c1b10ba18c7"
     default))
 '(display-line-numbers-type 'relative)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(evil go-mode gruber-darker-theme haskell-mode magit markdown-mode
	  rust-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
