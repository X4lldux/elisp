(require 'thingatpt)
(require 'perl-things)
(require 'my-macros)
(require 'cperl-test-increment)
(require 'cperl-dump)
(require 'cperl-use)
(require 'cperl-misc)
(require 'cperl-project)
(provide 'cperl-extras)

(add-hook 'cperl-mode-hook 
          (lambda ()
            (local-set-key "\C-ct" 'increment-test-counter)
            (local-set-key "\C-cu" 'add-use)
            (local-set-key "\C-cd" 'perl-insert-debug-statement)
            (local-set-key "\C-cs" 'insert-self-shift)
            (local-set-key "\C-cT" 'find-tests)))

