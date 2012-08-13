use utf8;
package PostAdminDB::Schema::Result::DomainAdmin;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PostAdminDB::Schema::Result::DomainAdmin - Postfix Admin - Domain Admins

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");

=head1 TABLE: C<domain_admins>

=cut

__PACKAGE__->table("domain_admins");

=head1 ACCESSORS

=head2 username

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 domain

  data_type: 'varchar'
  is_foreign_key: 1
  is_nullable: 0
  size: 255

=head2 created

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=head2 active

  data_type: 'boolean'
  default_value: true
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "username",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "domain",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 0, size => 255 },
  "created",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 1,
    original      => { default_value => \"now()" },
  },
  "active",
  { data_type => "boolean", default_value => \"true", is_nullable => 0 },
);

=head1 RELATIONS

=head2 domain

Type: belongs_to

Related object: L<PostAdminDB::Schema::Result::Domain>

=cut

__PACKAGE__->belongs_to(
  "domain",
  "PostAdminDB::Schema::Result::Domain",
  { domain => "domain" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07024 @ 2012-05-21 17:05:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:CqCVwGPd6j8VVpevGO08rA

# The PostfixAdmin database schema does not have this reference in it.
# I'll just add it here since I don't want us to have to alter the database.

__PACKAGE__->belongs_to(
  "admin",
  "PostAdminDB::Schema::Result::Admin",
  { username => "admin" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

1;
