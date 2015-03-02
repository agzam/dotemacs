; (autoload 'ghc-init "ghc" nil t)
; (autoload 'ghc-debug "ghc" nil t)
; (add-hook 'haskell-mode-hook
;          (lambda ()
;            (when (buffer-file-name)
;              (ghc-init))))

(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

'(haskell-interactive-popup-errors nil)
'(haskell-process-auto-import-loaded-modules t)
'(haskell-process-log t)
'(haskell-process-suggest-remove-import-lines t)

 (haskell-mode . (
    ;; Highlight leading space characters in Haskell files.
    (eval . (highlight-regexp "^ *")))))

(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
  (setenv "PATH" (concat my-cabal-path ":" (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path))
(custom-set-variables '(haskell-tags-on-save t))

(provide 'init-haskell)
