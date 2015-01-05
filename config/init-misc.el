(require-package 'undo-tree)
(setq undo-tree-auto-save-history t)
(setq undo-tree-history-directory-alist
      `(("." . ,(concat dotemacs-cache-directory "undo"))))
(setq undo-tree-visualizer-timestamps t)
(setq undo-tree-visualizer-diff t)
(global-undo-tree-mode)


(require-package 'multiple-cursors)
(after 'evil
  (add-hook 'multiple-cursors-mode-enabled-hook 'evil-emacs-state)
  (add-hook 'multiple-cursors-mode-disabled-hook 'evil-normal-state))


(require-package 'wgrep)


(when (executable-find "pt")
  (require-package 'pt)
  (require-package 'wgrep-pt))


(when (executable-find "ag")
  (require-package 'ag)
  (setq ag-highlight-search t)
  (add-hook 'ag-mode-hook (lambda () (toggle-truncate-lines t)))
  (require-package 'wgrep-ag))


(when (executable-find "ack")
  (require-package 'ack-and-a-half)
  (require-package 'wgrep-ack))


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
(add-to-list 'aggressive-indent-excluded-modes 'stylus-mode)
(add-to-list 'aggressive-indent-excluded-modes 'org-mode)
(global-aggressive-indent-mode)


(require-package 'etags-select)
(setq etags-select-go-if-unambiguous t)


(require-package 'windsize)
(require 'windsize)
(setq windsize-cols 16)
(setq windsize-rows 8)
(windsize-default-keybindings)


(require-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)


(require-package 'framemove)
(require 'framemove)
(setq framemove-hook-into-windmove t)


(require-package 'discover-my-major)


(when (eq system-type 'darwin)
  (require-package 'vkill))


;; make sure $PATH is set correctly
(if (eq system-type 'windows-nt)
    (dolist (path (split-string (getenv "PATH") ";"))
      (add-to-list 'exec-path (replace-regexp-in-string "\\\\" "/" path)))
  (progn
    (require-package 'exec-path-from-shell)
    (exec-path-from-shell-initialize)))

;; Evernote
(setq evernote-username "plotnick")
(setq evernote-developer-token "S=s9:U=1032d0:E=1519fc6f803:C=14a4815c938:P=1cd:A=en-devtoken:V=2:H=60020889830e06533a55a13fc1d565e7")
(setq evernote-mode-display-menu nil)


;; Thesaurus

;; (setq thesaurus-bhl-api-key "268e6dcef65d60cea2f54799ec62eec1") 

(setq synonyms-file        "~/.emacs.d/config/mthes10/mthesaur.txt")
(setq synonyms-cache-file  "~/.emacs.d/.cache/mtheasur.txt.cache")

(defun replace-word-other-window ()
  (interactive)
  (let ((sym (thing-at-point 'symbol))
        bnd)
    (other-window 1)
    (if (setq bnd (bounds-of-thing-at-point 'symbol))
        (progn
          (delete-region (car bnd) (cdr bnd))
          (insert sym))
      (message "no symbol at point in other window"))
    (other-window -1)))


;; Ignore Messages buffer for next-buffer/previous-buffer commands
(defadvice next-buffer (after avoid-messages-buffer-in-next-buffer)
  "Advice around `next-buffer' to avoid going into the *Messages* buffer."
  (when (string= "*Messages*" (buffer-name))
    (next-buffer)))

(defadvice previous-buffer (after avoid-messages-buffer-in-previous-buffer)
  "Advice around `previous-buffer' to avoid going into the *Messages* buffer."
  (when (string= "*Messages*" (buffer-name))
    (previous-buffer)))

(ad-activate 'next-buffer)
(ad-activate 'previous-buffer)


(provide 'init-misc)
