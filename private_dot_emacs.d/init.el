;;; init.el --- Kevin's Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; ---- Package manager ----
(require 'package)
(setq package-archives
  '(("gnu"   . "https://elpa.gnu.org/packages")
    ("melpa" . "https://melpa.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; ---- GUI ----
(setq inhibit-startup-message t
      visible-bell t)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(load-theme 'modus-vivendi t)
(add-to-list 'default-frame-alist
;;             '(font . "Spleen 8x16-12")
             '(font . "Atkinson Hyperlegible Mono-12")
             '(font . "Hack-12"))

;; line numbers for editing buffers only
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'text-mode-hook #'display-line-numbers-mode)

;; ---- backup file behavior ----

(make-directory (expand-file-name "backups" user-emacs-directory) t)
(setq backup-directory-alist
      `(("." . ,(expand-file-name "backups" user-emacs-directory))))

(make-directory (expand-file-name "autosaves" user-emacs-directory) t)
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "autosaves" user-emacs-directory) t)))

(setq make-backup-files t
      version-control t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      create-lockfiles nil)


;; ---- editing ----
(setq-default indent-tabs-mode nil
	      tab-width 4
	      fill-column 80)
(global-visual-line-mode 1)
(setq sentence-end-double-space nil)
(setq require-final-newline t)
(delete-selection-mode 1)   ; typing replaces selected region
(global-auto-revert-mode 1) ; reload buffer if file changes on disk
(setq global-auto-revert-non-file-buffers t)
(save-place-mode 1)         ; reopen files at last cursor pos
(recentf-mode 1)
(setq recentf-max-saved-items 200)

;; no delay on matching parens
(setq show-paren-delay 0)
(show-paren-mode 1)
(electric-pair-mode 1)

;; make C-z undo, rather than suspend
(use-package undo-fu
  :config
  (global-unset-key (kbd "C-z"))
  (global-set-key (kbd "C-z")   'undo-fu-only-undo)
  (global-set-key (kbd "C-S-z") 'undo-fu-only-redo))

(use-package undo-fu-session
  :config
  (setq undo-fu-session-incompatible-files '("/COMMIT_EDITMSG\\'" "/git-rebase-todo\\'"))
  (undo-fu-session-global-mode))

(savehist-mode 1)
(setq history-length 500)

;; ---- vertico; vertical completion ----
(use-package vertico
  :init (vertico-mode))
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil)
  (completion-pcm-leading-wildcard t))
(use-package marginalia
  :init (marginalia-mode 1))
(use-package consult
  :bind (("C-s"     . consult-line)
         ("C-x b"   . consult-buffer)
         ("M-y"     . consult-yank-pop)
         ("C-x r b" . consult-bookmark)))

;; ---- corfu; in-buffer completion ----
(use-package corfu
  :init
  (global-corfu-mode)
  )

;; ---- git ----
(use-package magit)

;; TODO language servers

(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . gfm-mode)
  :custom
  (markdown-command "cmark"))

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(undo-fu undo-fu-session)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
