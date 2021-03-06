(require-package 'undo-tree)
(setq undo-tree-auto-save-history t)
(setq undo-tree-history-directory-alist
      `(("." . ,(concat dotemacs-cache-directory "undo"))))
(setq undo-tree-visualizer-timestamps t)
(setq undo-tree-visualizer-diff t)
(global-undo-tree-mode)

(global-linum-mode 1)

(require-package 'multiple-cursors)
(after 'evil
  (add-hook 'multiple-cursors-mode-enabled-hook #'evil-emacs-state)
  (add-hook 'multiple-cursors-mode-disabled-hook #'evil-normal-state))


(require-package 'wgrep)


(when (executable-find "pt")
  (require-package 'pt)
  (require-package 'wgrep-pt))


(when (executable-find "ag")
  (require-package 'ag)
  (setq ag-highlight-search t)
  (add-hook 'ag-mode-hook (lambda () (toggle-truncate-lines t)))
  (require-package 'wgrep-ag))


(require-package 'project-explorer)
(after 'project-explorer
  (setq pe/cache-directory (concat dotemacs-cache-directory "project-explorer"))
  (setq pe/omit-regex (concat pe/omit-regex "\\|^node_modules$")))


(require-package 'ace-jump-mode)


(require-package 'expand-region)


(require-package 'editorconfig)
(require 'editorconfig)


(require-package 'aggressive-indent)
(require 'aggressive-indent)
(add-to-list 'aggressive-indent-excluded-modes #'stylus-mode)
(add-to-list 'aggressive-indent-excluded-modes #'org-mode)
(add-to-list 'aggressive-indent-excluded-modes #'vimrc-mode)
(global-aggressive-indent-mode)


(require-package 'etags-select)
(setq etags-select-go-if-unambiguous t)


(require-package 'windsize)
(require 'windsize)
(setq windsize-cols 16)
(setq windsize-rows 8)
(windsize-default-keybindings)


(require-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)


(require-package 'framemove)
(require 'framemove)
(setq framemove-hook-into-windmove t)


(require-package 'discover-my-major)


(require-package 'paradox)
(setq paradox-execute-asynchronously nil)


(when (eq system-type 'darwin)
  (require-package 'vkill))


;; make sure $PATH is set correctly
(if (eq system-type 'windows-nt)
    (dolist (path (split-string (getenv "PATH") ";"))
      (add-to-list 'exec-path (replace-regexp-in-string "\\\\" "/" path)))
  (progn
    (require-package 'exec-path-from-shell)
    (exec-path-from-shell-initialize)))

(setq-default line-spacing 5)

;; Evernote
(setq evernote-username "plotnick")
(setq evernote-mode-display-menu nil)


;; Ignore Messages buffer for next-buffer/previous-buffer commands
; (defadvice next-buffer (after avoid-messages-buffer-in-next-buffer)
;   "Advice around `next-buffer' to avoid going into the *Messages* buffer."
;   (when (string= "*Messages*" (buffer-name))
;     (next-buffer)))

; (defadvice previous-buffer (after avoid-messages-buffer-in-previous-buffer)
;   "Advice around `previous-buffer' to avoid going into the *Messages* buffer."
;   (when (string= "*Messages*" (buffer-name))
;     (previous-buffer)))

; (ad-activate 'next-buffer)
; (ad-activate 'previous-buffer)


(setq skippable-buffers '("*Messages*" "*helm M-x*" "*Quail Completions*" "*scratch*"))

(defun my-next-buffer ()
  "next-buffer that skips certain buffers"
  (interactive)
  (next-buffer)
  (while (member (buffer-name) skippable-buffers)
    (next-buffer)))

(defun my-previous-buffer ()
  "previous-buffer that skips certain buffers"
  (interactive)
  (previous-buffer)
  (while (member (buffer-name) skippable-buffers)
    (previous-buffer)))

(global-set-key [remap next-buffer] 'my-next-buffer)
(global-set-key [remap previous-buffer] 'my-previous-buffer)

(when window-system (set-frame-size (selected-frame) 200 70))

(provide 'init-misc)
