(set-face-attribute 'default nil
                    :font "DejaVuSansM Nerd Font Mono"
                    :height 170)

(load-theme 'modus-vivendi t)

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
(column-number-mode 1)
(show-paren-mode 1)
(electric-pair-mode 1)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(add-hook 'prog-mode-hook
          (lambda ()
            (display-fill-column-indicator-mode 1)
            (setq show-trailing-whitespace t)))

(setq c-basic-offset 4)

(setq backup-directory-alist
      `(("." . ,(expand-file-name "backups/" user-emacs-directory))))

(setq scroll-margin 5
      scroll-conservatively 101
      scroll-step 1)

(fset 'yes-or-no-p 'y-or-n-p)

(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"   . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(defmacro use-package-simple (pkg)
  `(unless (package-installed-p ',pkg)
     (package-install ',pkg)))

(use-package-simple evil)
(require 'evil)
(evil-mode 1)
