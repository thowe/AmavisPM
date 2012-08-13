package AmavisPM::Controller::Auth;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

AmavisPM::Controller::Auth - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched AmavisPM::Controller::Auth in Auth.');
}

=head2 login

=cut

sub login :Local :Args(0) {
    my ($self, $c) = @_;
    $c->stash->{'template'} = 'auth/login.tt';

    my $params = $c->req->params;

    # We will want to remember the requested URI so that once login
    # works we can get directed to it.
    my $requested;
    if( defined $params->{'requested'} ) {
        $requested = $params->{'requested'};
    }
    else {
        $requested = $c->req->uri;
    }

    $c->stash->{'requested'} = $requested;

    if( exists($params->{'username'}) ) {
        if( $c->authenticate({ username => $params->{'username'},
                               password => $params->{'password'},
                               active => [ 'true' ]
                             },
                             $params->{'realm'}) ) {

            $c->res->redirect($requested);
            $c->detach();
        }
        else {
            $c->stash->{'message'} = 'Authentication Failed';
        }
    }
}

=head2 logout

=cut

sub logout :Local :Args(0) {
    my ($self, $c) = @_;
    $c->stash->{'template'} = 'auth/logout.tt';

    $c->logout();
}

=head1 AUTHOR

Mail Domain Admin

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
