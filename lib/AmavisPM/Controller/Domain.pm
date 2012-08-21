package AmavisPM::Controller::Domain;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

AmavisPM::Controller::Domain - Catalyst Controller

=head1 DESCRIPTION

View and edit spam policies and white/black lists for domains and individual users.

=head1 METHODS

=cut

=head2 base

=cut

sub base :PathPart('domain') :Chained('/') :CaptureArgs(0) {
  my ($self, $c, $domain) = @_;
}

=head2 domain

If we are at /domain and we are an admin, we should display
a list of the domains available to this admin.

=cut

sub domain :PathPart('') :Chained('base') :Args(0) {
    my ($self, $c) = @_;
    $c->stash->{'template'} = 'domain/list.tt';

    $c->forward('check_realm_mailbox');

    my $admin = $c->model('PostAdminDB::Admin')->find(
                    { username => $c->user->username } );

    my @admin_domains = $admin->domains( { 'domain.active' => 1 },
                                         { order_by => 'domain' } );

    # ALL in the database means this admin can edit all domains.
    if ( grep(/\AALL\z/, map { $_->domain } @admin_domains) ) {
        @admin_domains = $c->model('PostAdminDB::Domain')->search(
                             { active => 1,
                               domain => { '!=' => 'ALL' } },
                             { order_by => 'domain' } );
    }

    my %domain_policies;
    foreach my $adomain (@admin_domains) {
        my $amavis_user = $c->model('AmavisDB::User')->find(
                              { 'email' => '@' . $adomain->domain } );

        if( defined $amavis_user ) {
            $domain_policies{$adomain} = $amavis_user->policy->policy_name;
        }
    }

    $c->stash->{'admin_user'} = $admin;
    $c->stash->{'admin_domains'} = \@admin_domains;
    $c->stash->{'domain_policies'} = \%domain_policies;
}

=head2 check_domain_admin

Make sure that the admin that is logged in is an admin for the specified domain.
If it is not, redirect to the beginning.

=cut

sub check_domain_admin :Private {
    my ($self, $c) = @_;

    my $admin = $c->model('PostAdminDB::Admin')->find(
                    { username => $c->user->username } );

    my $mail_domain = $c->stash->{'mail_domain'};

    if( !defined $admin ) {
        $c->response->redirect($c->uri_for(
            $c->controller('Auth')->action_for('logout') ));
        $c->detach();
    }

    my @admin_domains = $admin->domains(
                            { 'domain.active' => 1,
                              'domain.domain' => [ -or => { '=', $mail_domain->domain },
                                                          { '=', 'ALL' } ] },
                            {} );

    if( ! @admin_domains ) {
        $c->response->redirect($c->uri_for(
            $self->action_for('domain') ));
        $c->detach();
    }
}

=head2 check_realm_mailbox

If the user is in the mailbox realm, redirect to its page.

=cut

sub check_realm_mailbox :Private {
    my ($self, $c) = @_;

    if( $c->user_in_realm('mailbox') ) {
        my ( $username, $domain ) = split(/@/, $c->user->username);
        $c->response->redirect($c->uri_for(
            $self->action_for('mailbox') , [$domain, $username] ));
        $c->detach();
    }
}

=head2 domain_part

domain name capture part of a chain

=cut

sub domain_part :PathPart('') :Chained('base') :CaptureArgs(1) {
    my ($self, $c, $domain) = @_;


    my $mail_domain = $c->model('PostAdminDB::Domain')->find(
                          { domain => $domain,
                            active => 1 } );

    if( defined $mail_domain ) {
        $c->stash->{'mail_domain'} = $mail_domain;
    }
    else {
        $c->response->redirect($c->uri_for(
            $self->action_for('domain') ));
        $c->detach();
    }
}

=head2 domain_set_policy

Update the configured domain policy.

=cut

sub set_domain_policy :PathPart('setpolicy') :Chained('domain_part') :Args(0) {
    my ($self, $c) = @_;

    $c->forward('check_realm_mailbox');
    $c->forward('check_domain_admin');

    my $params = $c->req->params;

    my $mail_domain = $c->stash->{'mail_domain'};

    my $amavis_domain_user = $c->model('AmavisDB::User')->find(
                                 { 'email' => '@' . $mail_domain->domain } );

    my $amavis_policy = $c->model('AmavisDB::Policy')->find(
                                 { 'id' => $params->{'policy_select'} } ) if $params->{'policy_select'} ne 'none';

    if( $params->{'policy_select'} eq 'none' and defined $amavis_domain_user ) {
            $amavis_domain_user->delete;
    }
    elsif( defined $amavis_policy ) {
        if( defined $amavis_domain_user ) {
            $amavis_domain_user->policy( $amavis_policy );
            $amavis_domain_user->update;
        }
        else {
            $amavis_domain_user = $c->model('AmavisDB::User')->new(
                                      { 'email' => '@' . $mail_domain->domain,
                                        'priority' => 3,
                                        'policy_id' => $amavis_policy->id } );
            $amavis_domain_user->insert;
        }
    }

    $c->response->redirect($c->uri_for(
        $self->action_for('domain_view'), [$mail_domain->domain] ));
    $c->detach();
}

=head2 domain_view

If we are at /domain/somedomain.tld and we are an admin, we should
display the defaults for this domain and allow them to be edited.
We will also link to the domain mailboxes.

=cut

sub domain_view :PathPart('') :Chained('domain_part') :Args(0) {
    my ($self, $c) = @_;
    $c->stash->{'template'} = 'domain/domain_view.tt';

    $c->forward('check_realm_mailbox');
    $c->forward('check_domain_admin');

    my $mail_domain = $c->stash->{'mail_domain'};

    my @mailboxes = $mail_domain->mailboxes(
                        { 'active' => 1 },
                        { order_by => 'username' } );

    my $amavis_domain_user = $c->model('AmavisDB::User')->find(
                                 { 'email' => '@' . $mail_domain->domain } );

    my $policies_rs = $c->model('AmavisDB::Policy');

    my $amavis_policy;
    my (@whitelist, @blacklist);
    if( defined $amavis_domain_user ) {
        $amavis_policy = $amavis_domain_user->policy;
        @whitelist = $amavis_domain_user->blacklisted_addresses;
        @blacklist = $amavis_domain_user->whitelisted_addresses;
    }

    $c->stash->{'amavis_user'} = $amavis_domain_user;
    $c->stash->{'mailboxes'} = \@mailboxes;
    $c->stash->{'policy'} = $amavis_policy;
    $c->stash->{'whitelist'} = \@whitelist;
    $c->stash->{'blacklist'} = \@blacklist;
    $c->stash->{'available_policies'} = $policies_rs;
}

sub mailbox_part :PathPart('mailbox') :Chained('domain_part') :CaptureArgs(1) {
    my ($self, $c, $mailbox) = @_;

    my $mail_domain = $c->stash->{'mail_domain'};

    if( $c->user->username ne $mailbox . '@' . $mail_domain->domain ) {
        $c->forward('check_realm_mailbox');
        $c->forward('check_domain_admin');
    }

    #$c->response->body('Looks like we want ' . $mailbox . '@' . $c->stash->{'mail_domain'}->domain);
    $c->stash->{'mailbox'} = $mailbox;
    $c->stash->{'email_address'} = $mailbox . '@' . $mail_domain->domain;
}

sub mailbox_view :PathPart('') :Chained('mailbox_part') :Args(0) {
    my ($self, $c) = @_;

    $c->response->body('Looks like we want ' . $c->stash->{'email_address'});
}

=head1 AUTHOR

Mail Domain Admin

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
