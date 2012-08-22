package AmavisPM::Controller::Auth;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

AmavisPM::Controller::Auth - Catalyst Controller

=head1 DESCRIPTION

AmavisPM Authentication Controller

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

    if($c->user_exists) {
        if($c->req->path =~ /auth\/login/) {
            $c->response->redirect($c->uri_for(
                $c->controller('Domain')->action_for('domain') ));
            $c->detach();
        }
        else {
            $c->res->redirect($requested);
            $c->detach();
        }
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

Tim Howe <timh@dirtymonday.net>

=head1 LICENSE

This software is copyright (c) 2012 by Tim Howe.

This program is distributed in the hope that it will be useful, but it is
provided "as is" and without any express or implied warranties. For details,
see the full text of the license in the file LICENSE.

This code is free software; you can redistribute it and/or modify it under
the terms of the Artistic License 2.0. For details, see the full text of the
license in the file LICENSE.

=cut

__PACKAGE__->meta->make_immutable;

1;
