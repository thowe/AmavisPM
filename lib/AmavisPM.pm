package AmavisPM;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application.
#
# Note that ORDERING IS IMPORTANT here as plugins are initialized in order,
# therefore you almost certainly want to keep ConfigLoader at the head of the
# list if you're using it.
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
    ConfigLoader
    Static::Simple

    Authentication
    Session
    Session::State::Cookie
    Session::Store::FastMmap
/;

extends 'Catalyst';

our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in amavispm.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    # name => 'AmavisPM',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
    enable_catalyst_header => 1, # Send X-Catalyst header

    'View::HTML' => {
        INCLUDE_PATH => [ __PACKAGE__->path_to('root', 'src'),
                          __PACKAGE__->path_to('root', 'lib')],
        TEMPLATE_EXTENSION => '.tt',
        CATALYST_VAR       => 'c',
        TIMER              => 0,
    },
    'Plugin::Authentication' => {
        default_realm => 'mailbox',
        mailbox  => {
            credential => {
                class => 'Password',
                password_type => 'self_check'
            },
            store => {
                class => 'DBIx::Class',
                user_model => 'PostAdminDB::Mailbox',
                use_userdata_from_session => '1'
            }
        },
        admin => {
            credential => {
                class => 'Password',
                password_type => 'self_check'
            },
            store => {
                class => 'DBIx::Class',
                user_model => 'PostAdminDB::Admin',
                use_userdata_from_session => '1'
            }
        }
    }
);

# Start the application
__PACKAGE__->setup();


=head1 NAME

AmavisPM - Catalyst based application

=head1 SYNOPSIS

    script/amavispm_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<AmavisPM::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Mail Domain Admin

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
