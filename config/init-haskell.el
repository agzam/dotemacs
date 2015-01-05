(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook
         (lambda ()
           (when (buffer-file-name)
             (ghc-init))))
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

'(haskell-interactive-popup-errors nil)
'(haskell-process-auto-import-loaded-modules t)
'(haskell-process-log t)
'(haskell-process-suggest-remove-import-lines t)

(provide 'init-haskell)
