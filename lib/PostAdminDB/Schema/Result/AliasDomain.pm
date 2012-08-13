use utf8;
package PostAdminDB::Schema::Result::AliasDomain;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PostAdminDB::Schema::Result::AliasDomain - Postfix Admin - Domain Aliases

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

=head1 TABLE: C<alias_domain>

=cut

__PACKAGE__->table("alias_domain");

=head1 ACCESSORS

=head2 alias_domain

  data_type: 'varchar'
  is_foreign_key: 1
  is_nullable: 0
  size: 255

=head2 target_domain

  data_type: 'varchar'
  is_foreign_key: 1
  is_nullable: 0
  size: 255

=head2 created

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=head2 modified

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
  "alias_domain",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 0, size => 255 },
  "target_domain",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 0, size => 255 },
  "created",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 1,
    original      => { default_value => \"now()" },
  },
  "modified",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 1,
    original      => { default_value => \"now()" },
  },
  "active",
  { data_type => "boolean", default_value => \"true", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</alias_domain>

=back

=cut

__PACKAGE__->set_primary_key("alias_domain");

=head1 RELATIONS

=head2 alias_domain

Type: belongs_to

Related object: L<PostAdminDB::Schema::Result::Domain>

=cut

__PACKAGE__->belongs_to(
  "alias_domain",
  "PostAdminDB::Schema::Result::Domain",
  { domain => "alias_domain" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 target_domain

Type: belongs_to

Related object: L<PostAdminDB::Schema::Result::Domain>

=cut

__PACKAGE__->belongs_to(
  "target_domain",
  "PostAdminDB::Schema::Result::Domain",
  { domain => "target_domain" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07024 @ 2012-05-21 17:05:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:JgKF2pxBiq9kVHIczhcFqw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
