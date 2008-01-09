
(defun insert-self-shift (noshift)
  (interactive)
  (if noshift
      (insert "my ($self) = @_;\n")
    (insert "my $self = shift;\n"))
  (cperl-indent-command))

(defun cpan-install ()
  (interactive)
  (let ((module (read-with-default "Module" (thing-at-point 'perl-module)
                                   "You must specify a module to install!")))

    (start-process "cpan-process" "*cpan-install*"
                   "/home/jon/perl/install/bin/cpanp" "install" module)
    (set-window-buffer (split-window) "*cpan-install*")))

(global-set-key "\C-c\C-i" 'cpan-install)

(provide 'cperl-misc)
