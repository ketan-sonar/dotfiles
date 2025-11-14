(tool-bar-mode 0)
(scroll-bar-mode 0)
(global-display-line-numbers-mode)
(electric-pair-mode)

(set-face-attribute 'default nil :font "IosevkaTerm Nerd Font Mono-18")

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode)

(require 'evil)
(evil-mode)

(add-to-list 'load-path "~/.emacs.d/local/")
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
   '("e13beeb34b932f309fb2c360a04a460821ca99fe58f69e65557d6c1b10ba18c7"
     default))
 '(display-line-numbers-type 'relative)
 '(package-selected-packages '(evil go-mode gruber-darker-theme haskell-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
