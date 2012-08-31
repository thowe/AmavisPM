package AmavisPM::Controller::Domain;
use Moose;
use namespace::autoclean;

use Email::Valid;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

AmavisPM Domain Controller

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
            $self->action_for('mailbox_view') , [$domain, $username] ));
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

    my $policy_selected = $c->req->params->{'policy_select'};
    my $mail_domain = $c->stash->{'mail_domain'};
    my $amavis_user_email = '@' . $mail_domain->domain;

    $c->forward('setpolicy', [$amavis_user_email, $policy_selected,
                              $c->config->{'policy_priority_domain'}]);

    $c->response->redirect($c->uri_for(
        $self->action_for('domain_view'), [$mail_domain->domain] ));
    $c->detach();
}

=head2 domain_mailbox_policy

Update the configured mailbox policy.

=cut

sub set_mailbox_policy :PathPart('setpolicy') :Chained('mailbox_part') :Args(0) {
    my ($self, $c) = @_;

    my $policy_selected = $c->req->params->{'policy_select'};
    my $mail_domain = $c->stash->{'mail_domain'};
    my $amavis_user_email = $c->stash->{'email_address'};

    $c->forward('setpolicy', [$amavis_user_email, $policy_selected,
                              $c->config->{'policy_priority_mailbox'}]);

    $c->response->redirect($c->uri_for(
        $self->action_for('mailbox_view'), [$mail_domain->domain, $c->stash->{'mailbox'}] ));
    $c->detach();
}

=head2 add_domain_wbaddr

Add an address to a domain's white/black list.

=cut

sub add_domain_wbaddr :PathPart('addwblist') :Chained('domain_part') :Args(0) {
    my ($self, $c) = @_;

    $c->forward('check_realm_mailbox');
    $c->forward('check_domain_admin');

    my $mail_domain = $c->stash->{'mail_domain'};
    my $amavis_user_email = '@' . $mail_domain->domain;
    my $listed_address = $c->req->params->{'addwblist'};
    my $list_type = $c->req->params->{'listtype'};

    $c->forward('addwblist', [$amavis_user_email, $listed_address, $list_type]);

    $c->response->redirect($c->uri_for(
        $self->action_for('domain_view'), [$mail_domain->domain] ));
    $c->detach();
}

=head2 add_mailbox_wbaddr

Add an address to a mailbox's white/black list.

=cut

sub add_mailbox_wbaddr :PathPart('addwblist') :Chained('mailbox_part') :Args(0) {
    my ($self, $c) = @_;

    my $mail_domain = $c->stash->{'mail_domain'};
    my $amavis_user_email = $c->stash->{'email_address'};
    my $listed_address = $c->req->params->{'addwblist'};
    my $list_type = $c->req->params->{'listtype'};

    $c->forward('addwblist', [$amavis_user_email, $listed_address, $list_type]);

    $c->response->redirect($c->uri_for(
        $self->action_for('mailbox_view'), [$mail_domain->domain, $c->stash->{'mailbox'}] ));
    $c->detach();
}

=head2 delete_domain_wbaddr

Delete addresses from a domains's white/black list.

=cut

sub delete_domain_wbaddr :PathPart('delwblist') :Chained('domain_part') :Args(0) {
    my ($self, $c) = @_;

    $c->forward('check_realm_mailbox');
    $c->forward('check_domain_admin');

    my $params = $c->req->params;
    my $mail_domain = $c->stash->{'mail_domain'};
    my $amavis_user_email = '@' . $mail_domain->domain;
    my $listed_addresses = $params->{'wblist_select'};

    $c->forward('delwblist', [$amavis_user_email, $listed_addresses]);

    $c->response->redirect($c->uri_for(
        $self->action_for('domain_view'), [$mail_domain->domain] ));
    $c->detach();
}

=head2 delete_mailbox_wbaddr

Delete addresses from a mailbox's white/black list.

=cut

sub delete_mailbox_wbaddr :PathPart('delwblist') :Chained('mailbox_part') :Args(0) {
    my ($self, $c) = @_;

    my $params = $c->req->params;
    my $mail_domain = $c->stash->{'mail_domain'};
    my $amavis_user_email = $c->stash->{'email_address'};
    my $listed_addresses = $params->{'wblist_select'};

    $c->forward('delwblist', [$amavis_user_email, $listed_addresses]);

    $c->response->redirect($c->uri_for(
        $self->action_for('mailbox_view'), [$mail_domain->domain, $c->stash->{'mailbox'}] ));
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
        @whitelist = $amavis_domain_user->whitelisted_addresses;
        @blacklist = $amavis_domain_user->blacklisted_addresses;
    }

    $c->stash->{'amavis_user'} = $amavis_domain_user;
    $c->stash->{'mailboxes'} = \@mailboxes;
    $c->stash->{'policy'} = $amavis_policy;
    $c->stash->{'whitelist'} = \@whitelist;
    $c->stash->{'blacklist'} = \@blacklist;
    $c->stash->{'available_policies'} = $policies_rs;
}

=head2 mailbox_part

mailbox capture part of a chain

=cut

sub mailbox_part :PathPart('mailbox') :Chained('domain_part') :CaptureArgs(1) {
    my ($self, $c, $mailbox) = @_;

    my $mail_domain = $c->stash->{'mail_domain'};

    if( $c->user->username ne $mailbox . '@' . $mail_domain->domain ) {
        $c->forward('check_realm_mailbox');
        $c->forward('check_domain_admin');
    }

    $c->stash->{'mailbox'} = $mailbox;
    $c->stash->{'email_address'} = $mailbox . '@' . $mail_domain->domain;
}

=head2 mailbox_view

If we are at /domain/somedomain.tld/mailbox/username and we are an admin for
the domain or the user in question, we should display the defaults for this
user and allow them to be edited.

=cut

sub mailbox_view :PathPart('') :Chained('mailbox_part') :Args(0) {
    my ($self, $c) = @_;
    $c->stash->{'template'} = 'domain/mailbox_view.tt';

    my $amavis_user = $c->model('AmavisDB::User')->find(
                          { 'email' => $c->stash->{'email_address'} } );

    my $policies_rs = $c->model('AmavisDB::Policy');

    my $amavis_policy;
    my (@whitelist, @blacklist);
    if( defined $amavis_user ) {
        $amavis_policy = $amavis_user->policy;
        @whitelist = $amavis_user->whitelisted_addresses;
        @blacklist = $amavis_user->blacklisted_addresses;
    }

    $c->stash->{'amavis_user'} = $amavis_user;
    $c->stash->{'policy'} = $amavis_policy;
    $c->stash->{'whitelist'} = \@whitelist;
    $c->stash->{'blacklist'} = \@blacklist;
    $c->stash->{'available_policies'} = $policies_rs;
}

=head2 setpolicy

Set the policy for a domain or mailbox user in the amavis database.

=cut

sub setpolicy :Private {
    my ($self, $c, $email, $policy_id, $priority) = @_;

    my $amavis_user = $c->model('AmavisDB::User')->find(
                          { 'email' => $email } ) if defined $email;

    my $amavis_policy = $c->model('AmavisDB::Policy')->find(
                             { 'id' => $policy_id } ) if defined $policy_id and
                                                         $policy_id =~ /\A\d+\z/;

    # If the policy is being deleted, the amavisd-new user must be deleted.
    # When we do this we must also clear the wblist for the user.
    if( $policy_id eq 'none' and defined $amavis_user ) {
        my @mailaddrs = $amavis_user->white_black_addresses;
        foreach my $mailaddr (@mailaddrs) {
            $amavis_user->remove_from_white_black_addresses( $mailaddr );
        }
        $amavis_user->delete;
    }
    elsif( defined $amavis_policy ) {
        if( defined $amavis_user ) {
            $amavis_user->policy( $amavis_policy );
            $amavis_user->update;
        }
        elsif(defined $priority and $priority =~ /\A\d+\z/) {
            $amavis_user = $c->model('AmavisDB::User')->new(
                               { 'email' => $email,
                                 'priority' => $priority,
                                 'policy_id' => $amavis_policy->id } );
            $amavis_user->insert;
        }
    }

}

sub addwblist :Private {
    my ($self, $c, $email, $listed, $wb) = @_;
    my $valid_listed;
    my $priority;

    my $amavis_user = $c->model('AmavisDB::User')->find(
                          { 'email' => $email } ) if defined $email;

    if( $listed =~ /\A@/ ) {
        $valid_listed = 'dummy' . $listed;
        $priority = $c->config->{'mailaddr_priority_domain'};
    }
    else {
        $valid_listed = $listed;
        $priority = $c->config->{'mailaddr_priority_mailbox'};
    }

    return 1 if( !Email::Valid->address($valid_listed) );

    my $mailaddr = $c->model('AmavisDB::Mailaddr')->find(
                       { 'email' => $listed } );

    if( defined $amavis_user and $wb =~ /\A(W|B)\z/ ) {
        if( ! defined $mailaddr ) {
            $mailaddr = $c->model('AmavisDB::Mailaddr')->new(
                            { 'priority' => $priority,
                              'email' => $listed } );
            $mailaddr->insert;
        }
        elsif( $amavis_user->white_black_addresses(
                   { 'email' => $listed } )->count != 0 ) {
            return 1;
        }

        $amavis_user->add_to_white_black_addresses( $mailaddr,
                                                    { 'wb' => $wb } );
    }

}

sub delwblist :Private {
    my ($self, $c, $email, $listed) = @_;

    my $amavis_user = $c->model('AmavisDB::User')->find(
                          { 'email' => $email } ) if defined $email;

    return 1 if( ! defined $amavis_user or ! defined $listed );

    if( ref($listed) eq 'ARRAY') {
        foreach my $wba (@$listed) {
            my $mailaddr = $c->model('AmavisDB::Mailaddr')->find(
                               { 'id' => $wba } );
            $amavis_user->remove_from_white_black_addresses( $mailaddr );
        }
    }
    else {
        my $mailaddr = $c->model('AmavisDB::Mailaddr')->find(
                               { 'id' => $listed } );
        $amavis_user->remove_from_white_black_addresses( $mailaddr );
    }
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
