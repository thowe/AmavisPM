package AmavisPM::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

AmavisPM::Controller::Root - Root Controller for AmavisPM

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 auto

The root auto function checks that a user is logged in before allowing
anything else to happen.  If a user is not logged in, then we redirect
to the login page.  Otherwise we go about our normal business.

=cut

sub auto : Private {
    my ($self, $c) = @_;
    $c->stash->{'logoname'} = $c->config->{'logoname'};
    if(!$c->user_exists() && $c->req->path() ne 'auth/logout') {
        $c->detach('/auth/login');
    }
    return 1;
}

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->redirect($c->uri_for(
        $c->controller('Domain')));
    $c->detach();
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Tim Howe <timh@dirtymonday.net>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
