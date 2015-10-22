package App::docsisious::tftpd;

=head1 NAME

App::docsisious::tftpd - TFTPd server for docsisious

=head1 DESCRIPTION

This class holds logic that can serve config files from L<App::docsisious>.

=head1 SYNOPSIS

It is suggested to use iptables to forward the requests to an unpriviledged
port, so you don't have to run the application as root.

  $ DOCSISIOUS_TFTPD_LISTEN=tftp://*:6969 docsisious daemon

=cut

use Mojo::Base -base;
use File::Spec::Functions qw( catdir catfile );
use Mojo::TFTPd;

=head1 ATTRIBUTES

=head2 listen

  $str = $self->listen;

Returns a listen string. Defaults to C<DOCSISIOUS_TFTPD_LISTEN>.
Example: "tftp://*:12345".

=head2 log

  $log = $self->log;

Holds a L<Mojo::Log> object.

=head2 storage

  $path = $self->storage;

Path to where the files can be found. Default to L<DOCSIS_STORAGE>.

=head2 tftpd

  $tftpd = $self->tftpd;

Holds an instance of L<Mojo::TFTPd>

=cut

has listen  => sub { $ENV{DOCSISIOUS_TFTPD_LISTEN} };
has log     => sub { Mojo::Log->new };
has storage => sub { $ENV{DOCSIS_STORAGE} || ($ENV{HOME} ? catdir $ENV{HOME}, '.docsisious' : '') };
has tftpd => sub { Mojo::TFTPd->new(listen => shift->listen) };

=head1 METHODS

=head2 start

Used to start the TFTPd server.

=cut

sub start {
  my $self   = shift;
  my $listen = $self->listen or return $self;
  my $tftpd  = $self->tftpd;

  Scalar::Util::weaken($self);
  $tftpd->on(error => sub { $self->log->error("[TFTPd] $_[1]") });
  $tftpd->on(
    finish => sub {
      my ($tftpd, $c, $err) = @_;
      if ($err) {
        $self->log->error(sprintf "[TFTPd] %s %s %s FAIL %s", $c->peerhost, $c->type, $c->file, $err);
      }
      else {
        $self->log->info(sprintf "[TFTPd] %s %s %s SUCCESS", $c->peerhost, $c->type, $c->file);
      }
    }
  );

  $tftpd->on(
    rrq => sub {
      my ($tftpd, $c) = @_;
      my $path = catfile $self->storage, $c->file;
      $c->file =~ /^\w+\.bin$/ or die "Invalid file: @{[$c->file]}";
      open my $FH, '<', $path or return;
      $self->log->debug(sprintf "[TFTPd] %s rrq %s", $c->peerhost, $c->file);
      $c->filehandle($FH);
      $c->filesize(-s $path);
    }
  );

  $self->log->info(sprintf "Listening at %s", $self->listen);
  $tftpd->start;

  return $self;
}

=head1 AUTHOR

Jan Henning Thorsen - C<jhthorsen@cpan.org>

=cut

1;
