(set-face-attribute 'default nil
                    :font "IosevkaTerm Nerd Font Mono"
                    :height 180)

(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode 0)

(setq ring-bell-function 'ignore)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default fill-column 80)

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook
          (lambda ()
            (unless (derived-mode-p 'term-mode 'vterm-mode)
              (display-line-numbers-mode 1))))

(column-number-mode 1)
(show-paren-mode 1)
(electric-pair-mode 1)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-enable-prefix nil
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess)
(ido-mode 1)

(add-hook 'prog-mode-hook
          (lambda ()
            (display-fill-column-indicator-mode 1)
            (setq show-trailing-whitespace t)))

(setq c-basic-offset 4)

(let ((autosave-dir (expand-file-name "autosaves/" user-emacs-directory)))
  (unless (file-directory-p autosave-dir)
    (make-directory autosave-dir t))
  (setq auto-save-file-name-transforms
        `((".*" ,autosave-dir t))))

(setq backup-directory-alist
      `(("." . ,(expand-file-name "backups/" user-emacs-directory))))

(setq scroll-margin 5
      scroll-conservatively 101
      scroll-step 1)

(fset 'yes-or-no-p 'y-or-n-p)

(setq package-enable-at-startup nil)
(setq package-quickstart t)

(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"   . "https://elpa.gnu.org/packages/")))

(defvar packages-refreshed nil)
(defmacro ensure-package (pkg)
  `(unless (package-installed-p ',pkg)
     (unless packages-refreshed
       (package-refresh-contents)
       (setq packages-refreshed t))
     (package-install ',pkg)))

(ensure-package gruber-darker-theme)
(require 'gruber-darker-theme)
(load-theme 'gruber-darker t)

;; (ensure-package catppuccin-theme)
;; (require 'catppuccin-theme)
;; (setq catppuccin-flavor 'mocha)
;; (load-theme 'catppuccin t)
;; (catppuccin-set-color 'base "#101019")
;; (catppuccin-reload)

(setq gc-cons-threshold (* 50 1000 1000))

(setq evil-want-C-u-scroll t)
(setq evil-insert-state-cursor '(bar . 1))
(ensure-package evil)
(require 'evil)
(evil-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
