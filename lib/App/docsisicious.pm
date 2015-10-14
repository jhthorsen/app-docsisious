package App::docsisicious;

=head1 NAME

App::docsisicious - Edit DOCSIS config files

=head1 VERSION

0.01

=head1 DESCRIPTION

L<App::docsisicious> is a L<Mojolicious> web application for editing
DOCSIS config files.

=head1 SYNOPSIS

  # Step 1:
  $ docsisicious --listen http://*:8000
  # Step 2:
  $ open http://localhost:8000

=cut

use Mojo::Base -base;
use File::Spec::Functions 'catdir';
use File::Basename 'dirname';
use constant HOME => catdir dirname(__FILE__), 'docsisicious';

our $VERSION = '0.01';

=head1 COPYRIGHT AND LICENSE

=head2 Icons

=over 4

=item * L<Daniel Bruce|http://www.flaticon.com/free-icon/question-mark_3711>

=item * L<Dave Gandy|http://www.flaticon.com/free-icon/fullscreen-arrows-symbol_25183>

=item * L<Egor Rumyantsev|http://www.flaticon.com/free-icon/settings-work-tool_70367">

=item * L<Freepik|http://www.flaticon.com/free-icon/save-icon_64052>

=item * L<Google|http://www.flaticon.com/free-icon/download-button_60721>

=back

=head2 Code

Copyright (C) 2014, Jan Henning Thorsen

This program is free software, you can redistribute it and/or modify it under
the terms of the Artistic License version 2.0.

=head1 AUTHOR

Jan Henning Thorsen - C<jhthorsen@cpan.org>

=cut

1;
