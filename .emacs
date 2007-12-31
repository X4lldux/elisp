;;; load extra modes
(add-to-list 'load-path "/home/jon/elisp")
(add-to-list 'load-path "/home/jon/elisp/haskell-mode/")
(add-to-list 'load-path "/home/jon/elisp/ecb")
(add-to-list 'load-path "~/elisp/eieio-0.17")
(add-to-list 'load-path "~/elisp/speedbar-0.14beta4/")
(add-to-list 'load-path "~/elisp/semantic-1.4.4")
(add-to-list 'load-path "~/elisp/_local")

(load-file "/home/jon/elisp/nxml-mode-20041004/rng-auto.el")
(load-file "/home/jon/elisp/css-mode.el")
(load-file "/home/jon/elisp/vc-svk.el")
(load-file "/home/jon/elisp/tt-mode.el")
(load-file "/home/jon/elisp/php-mode.el")
(load-file "/home/jon/elisp/pir-mode.el")
(load-file "/home/jon/elisp/vc-svk.el")
;(load-file "/home/jon/elisp/visible-mark.el")
(load-file "/home/jon/elisp/chop.el")
(load-file "/home/jon/elisp/haskell-mode/haskell-mode.el")
(load-file "/home/jon/elisp/template/lisp/template.el")
(load-file "/home/jon/elisp/ecb/ecb.el")
(load-file "/home/jon/elisp/javascript.el")
(load-file "/home/jon/elisp/perly-sense.el")

(autoload 'tt-mode "tt-mode")
(autoload 'pir-mode "pir-mode")
(autoload 'chop "chop")
(require 'template)
(template-initialize)
;(require 'git)
(require 'amarok)
(require 'javascript-mode)
(require 'perly-sense)
(require 'cperl-extras)
(require 'elisp-extras)

;;; modes i want on by default
(server-start)
(diary 0)
(iswitchb-mode)
(desktop-save-mode 1)
(winner-mode)
(display-time)
(defalias 'perl-mode 'cperl-mode)

;;; hooks
(defun text-hooks ()
  "This function turns modes that I need when editing English text."
  (turn-on-auto-fill)
  (flyspell-mode 1)
  (local-set-key "\C-ccw" 'ispell-complete-word))

(defun cperl-hooks ()
  (local-set-key (kbd "\C-c p f") 'perly-sense-find-source-for-module-at-point)
  (local-set-key (kbd "\C-c p p") 'perly-sense-display-pod-for-module-at-point)
  (local-set-key (kbd "\C-c p d") 'perly-sense-smart-docs-at-point)
  (local-set-key (kbd "\C-c p g") 'perly-sense-smart-go-to-at-point)
  (local-set-key (kbd "\C-c p c") 'perly-sense-class-overview-for-class-at-point)
  (local-set-key (kbd "\C-c p a") 'perly-sense-display-api-for-class-at-point)
  (local-set-key (kbd "\C-c p \C-m") 'perly-sense-class-mode))

;;; hooks
;(setq last-kbd-macro
;   "\C-s(add-hook\C-m\C-a\C-k\C-k\C-x/t\C-xjk\C-y\C-x/k\C-xjt")
;(add-hook 'latex-mode-hook 'latex-top)
(add-hook 'text-mode-hook 'text-hooks)
(add-hook 'tex-mode-hook (function (lambda () (setq ispell-parser 'tex))))
(add-hook 'c-mode-common-hook (function (lambda () (local-set-key '"\C-c\C-f" 'compile))))
(add-hook 'c-mode-common-hook (function (lambda () (local-set-key '"\C-c\C-l" 'goto-line))))
(add-hook 'c-mode-common-hook (lambda () (c-toggle-auto-hungry-state 1)))
(add-hook 'diary-hook 'appt-make-list)
(add-hook 'cperl-mode-hook 'cperl-hooks)

(add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

;;; auto-modes
(setq auto-mode-alist
      (append               
       '(("\\.css$" . css-mode)
         ("^mutt-" . mail-mode)
         ("\\.html$" . html-mode)
         ("configure.in" . m4-mode)
         ("\\.t$" . cperl-mode)
         ("\\.tt2?$" . tt-mode)
         ("\\.pir$" . pir-mode)
         ("\\.[hg]s$"  . haskell-mode)
         ("\\.hi$"     . haskell-mode)
         ("\\.elt$"    . emacs-lisp-mode)
         ("\\.l[hg]s$" . literate-haskell-mode))
       auto-mode-alist))

(add-to-list 'auto-mode-alist 
             (cons (concat "\\." (regexp-opt '("xml" "xsd" "sch" "rng" 
                                               "xslt" "svg" "rss") t) "\\'")
                   'nxml-mode))

;;; enable/disable
(put 'downcase-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'upcase-region 'disabled nil)

;;; functions for keybindings
(defun underscore ()
  (interactive)
  (insert-string "_"))

;;; advice
(require 'flymake)
(defadvice flymake-perl-init (after fix-flymake-perl-path)
  (setq ad-return-value 
        (list "/home/jon/perl/install/bin/perl"
              (list "-c " (cadadr ad-return-value)))))
(ad-activate 'flymake-perl-init)

;;; key-bindings
(global-set-key [kp-decimal] 'goto-line)
(global-set-key "\C-xg" 'grep-tree)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
(global-set-key "\C-h" 'backward-delete-char-untabify)
(global-set-key (kbd "C-;") 'underscore)
(global-set-key (kbd "C-c a p") 'amarok-play-pause)
(global-set-key (kbd "C-c a f") 'amarok-next)
(global-set-key (kbd "C-c a b") 'amarok-prev)
(global-set-key (kbd "C-c a s") 'amarok-seek)
(global-set-key "\C-c\C-r" 'revert-buffer)

;;; setqs
(setq cperl-invalid-face nil) 
(setq cperl-electric-keywords nil)
(setq cperl-hairy nil)
(setq fill-column 78)
(setq auto-fill-mode t)
(setq calendar-latitude 41.791489)
(setq calendar-longitude -87.601644)
(setq calendar-location-name "Research Institutes, Univ. of Chicago")
(setq frame-title-format "%b - emacs")

;;; custom-set
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(blink-matching-paren nil)
 '(blink-matching-paren-on-screen nil)
 '(c-cleanup-list (quote (empty-defun-braces defun-close-semi list-close-comma scope-operator compact-empty-funcall)))
 '(c-default-style (quote ((java-mode . "java") (other . "gnu"))))
 '(c-electric-pound-behavior (quote (alignleft)))
 '(c-macro-cppflags "-I/usr/include -I/usr/local/include -I/usr/include/g++-3")
 '(case-fold-search t)
 '(compilation-ask-about-save nil)
 '(compilation-read-command nil)
 '(compilation-scroll-output t)
 '(compilation-window-height 10)
 '(compile-auto-highlight 10)
 '(compile-command "make")
 '(cperl-close-paren-offset -4)
 '(cperl-continuted-statement-offset 0)
 '(cperl-indent-level 4)
 '(cperl-indent-parens-as-block t)
 '(cperl-inent-level 4)
 '(cperl-tab-always-indent t)
 '(cperl-under-as-char nil)
 '(current-language-environment "UTF-8")
 '(debug-on-error (quote (nil)) nil nil "All of them, darn it :)")
 '(display-hourglass nil)
 '(display-time-interval 5)
 '(display-time-mode t)
 '(ecb-options-version "2.32")
 '(ecb-source-path (quote ("~/projects")))
 '(erc-email-userid "jon@jrock.us")
 '(erc-nick "jrockway")
 '(erc-nick-uniquifier "_")
 '(erc-server "stonepath.jrock.us")
 '(erc-track-exclude-types (quote ("JOIN" "KICK" "NICK" "PART" "QUIT" "MODE")))
 '(erc-truncate-mode t)
 '(erc-whowas-on-nosuchnick t)
 '(eudc-protocol (quote ldap))
 '(eudc-server "ldap.uchicago.edu")
 '(flymake-allowed-file-name-masks (quote (("\\.c\\'" flymake-simple-make-init) ("\\.cpp\\'" flymake-simple-make-init) ("\\.xml\\'" flymake-xml-init) ("\\.html?\\'" flymake-xml-init) ("\\.cs\\'" flymake-simple-make-init) ("\\.p[lm]\\'" flymake-perl-init) ("\\.t\\'" flymake-perl-init) ("\\.h\\'" flymake-master-make-header-init flymake-master-cleanup) ("\\.java\\'" flymake-simple-make-java-init flymake-simple-java-cleanup) ("[0-9]+\\.tex\\'" flymake-master-tex-init flymake-master-cleanup) ("\\.tex\\'" flymake-simple-tex-init) ("\\.idl\\'" flymake-simple-make-init))))
 '(flyspell-issue-welcome-flag nil)
 '(flyspell-mode-line-string " Spell ")
 '(font-lock-global-modes t)
 '(global-font-lock-mode t nil (font-lock))
 '(grep-tree-command "find <D> -path '*/.svn' -prune -o <X> -type f <F> -print0 | xargs -0 -e egrep <C> -nH -e  '<R>'")
 '(haskell-font-lock-symbols (quote unicode))
 '(haskell-literate-default (quote latex))
 '(indent-tabs-mode nil)
 '(inferior-lisp-program "clisp")
 '(inhibit-startup-screen t)
 '(jde-compiler (quote ("javac" "")))
 '(jde-gen-conditional-padding-1 " ")
 '(jde-gen-conditional-padding-3 "")
 '(jde-gen-method-signature-padding-3 "")
 '(jde-help-docsets (quote (("JDK API" "/usr/local/java/docs/api" nil))))
 '(make-backup-files nil)
 '(max-lisp-eval-depth 65536)
 '(menu-bar-mode nil nil (menu-bar))
 '(mouse-avoidance-mode (quote animate) nil (avoid))
 '(pgg-default-user-id "5BF3666D")
 '(pgg-gpg-use-agent t)
 '(rcirc-default-server "irc.perl.org")
 '(save-place t nil (saveplace))
 '(scheme-program-name "guile")
 '(scroll-bar-mode nil)
 '(server-done-hook (quote (not-modified delete-frame)))
 '(server-visit-hook (quote (new-frame focus-frame)))
 '(server-window nil)
 '(show-paren-mode t)
 '(speedbar-frame-parameters (quote ((minibuffer) (width . 40) (border-width . 0) (menu-bar-lines . 0) (tool-bar-lines . 0) (unsplittable . t))))
 '(speedbar-use-images nil)
 '(sql-electric-stuff (quote semicolon))
 '(template-auto-insert t)
 '(template-confirm-insecure nil)
 '(template-subdirectories (quote ("./" "Templates/")))
 '(tex-default-mode (quote latex-mode))
 '(tex-dvi-view-command "xdvi")
 '(tex-shell-window-height 10)
 '(tex-show-queue-command " lpq")
 '(tool-bar-mode nil nil (tool-bar))
 '(vc-handled-backends (quote (SVK RCS CVS SVN SCCS Arch MCVS GIT)))
 '(woman-cache-filename "/home/jon/.wmncach.el"))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "black" :foreground "gray" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal))))
 '(cperl-array ((((class color) (background dark)) (:background "navy" :foreground "yellow"))))
 '(cperl-hash ((((class color) (background dark)) (:background "navy" :foreground "Red"))))
 '(cursor ((t (:background "turquoise" :inverse-video t))))
 '(flymake-errline ((((class color)) (:box (:line-width 2 :color "red" :style released-button)))))
 '(flymake-warnline ((((class color)) (:box (:line-width 2 :color "yellow" :style released-button)))))
 '(flyspell-duplicate-face ((t (:foreground "Blue" :inverse-video t :weight bold))) t)
 '(flyspell-incorrect-face ((t (:foreground "OrangeRed" :inverse-video t :weight bold))) t)
 '(mode-line ((((class color) (min-colors 88)) (:background "grey" :foreground "black" :height 0.8)))))

(put 'narrow-to-region 'disabled nil)
