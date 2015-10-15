package App::docsisious;

=head1 NAME

App::docsisious - Edit DOCSIS config files on web

=head1 VERSION

0.02

=head1 DESCRIPTION

L<App::docsisious> is a L<Mojolicious> web application for editing
DOCSIS config files.

Try out L<http://home.thorsen.pm/docsisious> for a demo.

=head1 SYNOPSIS

  # Step 1:
  $ docsisious --listen http://*:8000
  # Step 2:
  $ open http://localhost:8000

=cut

use Mojo::Base -base;
use File::Spec::Functions 'catdir';
use File::Basename 'dirname';
use constant HOME => catdir dirname(__FILE__), 'docsisious';

our $VERSION = '0.02';

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
