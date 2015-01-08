(set-input-method 'russian-computer)

(setq-default ispell-program-name "aspell")

(require 'flyspell)
(require 'ispell)

(setq
 ; i like aspel, and you?
 ispell-program-name "aspell"

 ; my dictionary-alist, using for redefinition russian dictionary
 ispell-dictionary-alist 
 '(("english"                       ; English
    "[a-zA-Z]"
    "[^a-zA-Z]"
    "[']"
    nil
    ("-d" "en")
    nil iso-8859-1)
   ("ru"                       ; Russian
    "[АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯабвгдеёжзийклмнопрстуфхцчшщьыъэюя]"
    "[^АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯабвгдеёжзийклмнопрстуфхцчшщьыъэюя]"
    "[-]"
    nil
    ("-C" "-d" "ru")
    nil utf-8)
   (nil                             ; Default
    "[A-Za-z]"
    "[^A-Za-z]"
    "[']"
    nil
    ("-C")
    nil iso-8859-1))

 ispell-russian-dictionary "ru"
 ispell-english-dictionary "english"
 flyspell-default-dictionary ispell-russian-dictionary
 flyspell-dictionary ispell-russian-dictionary
 ispell-dictionary ispell-english-dictionary
 ispell-local-dictionary ispell-russian-dictionary
 ispell-extra-args '("--sug-mode=ultra"))

(defun flyspell-russian ()
  (interactive)
  (flyspell-mode t)
  (ispell-change-dictionary ispell-russian-dictionary)
  (flyspell-buffer)
  (message "Russian dictionary - Spell Checking completed."))

; English
(defun flyspell-english ()
  (interactive)
  (flyspell-mode t)
  (ispell-change-dictionary ispell-english-dictionary)
  (flyspell-buffer)
  (message "English dictionary - Spell Checking completed."))

(setq ispell-highlight-face (quote flyspell-incorrect))
(setq ispell-have-new-look t)
; (setq ispell-enable-tex-parser t)
;(add-hook 'text-mode-hook 'flyspell-russian)
(setq flyspell-delay 1)
(setq flyspell-always-use-popup t)






;; Thesaurus
;; (setq thesaurus-bhl-api-key "268e6dcef65d60cea2f54799ec62eec1") 
;; Synonyms
(setq synonyms-file        "~/.emacs.d/config/mthes10/mthesaur.txt")
(setq synonyms-cache-file  "~/.emacs.d/.cache/mtheasur.txt.cache")

;; Replaces word in adjacent window with the one that selected (under cursor) in active window
;; mainly used with synonyms
(defun region-or-symbol-bounds ()
  (if (region-active-p)
      (cons (region-beginning)
            (region-end))
    (bounds-of-thing-at-point 'symbol)))

(defun replace-word-other-window ()
  (interactive)
  (let* ((bnd-1 (region-or-symbol-bounds))
         (str-1 (buffer-substring-no-properties
                 (car bnd-1)
                 (cdr bnd-1)))
         (bnd-2 (progn
                  (other-window 1)
                  (region-or-symbol-bounds))))
    (if bnd-2
        (progn
          (delete-region (car bnd-2) (cdr bnd-2))
          (insert str-1))
      (message "no region or symbol at point in other window"))
    (other-window -1)
    (kill-buffer)
    (delete-window))) 

(provide 'init-text)