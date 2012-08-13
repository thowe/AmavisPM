#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install 1.02;
use Module::Install::Catalyst; # Complain loudly if you don't have
                               # Catalyst::Devel installed or haven't said
                               # 'make dist' to create a standalone tarball.

name 'AmavisPM';
all_from 'lib/AmavisPM.pm';

requires 'Catalyst::Runtime' => '5.90012';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Moose';
requires 'namespace::autoclean';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
test_requires 'Test::More' => '0.88';

requires 'Catalyst::Helper::View::TT';
requires 'DBD::Pg';
requires 'Catalyst::Helper::Model::DBIC::Schema';
requires 'DBIx::Class::TimeStamp';
requires 'Catalyst::Plugin::Authentication';
requires 'Catalyst::Authentication::Store::DBIx::Class';
requires 'Catalyst::Plugin::Session';
requires 'Catalyst::Plugin::Session::State::Cookie';
requires 'Catalyst::Plugin::Session::Store::FastMmap';
#requires 'DBIx::Class::Schema::Loader';
requires 'DateTime::Format::Pg';
#requires 'Crypt::PasswdMD5';
requires 'Digest::MD5';

catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
