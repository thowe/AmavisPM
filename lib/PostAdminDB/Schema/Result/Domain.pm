use utf8;
package PostAdminDB::Schema::Result::Domain;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PostAdminDB::Schema::Result::Domain - Postfix Admin - Virtual Domains

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

=head1 TABLE: C<domain>

=cut

__PACKAGE__->table("domain");

=head1 ACCESSORS

=head2 domain

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 description

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 aliases

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 mailboxes

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 maxquota

  data_type: 'bigint'
  default_value: 0
  is_nullable: 0

=head2 quota

  data_type: 'bigint'
  default_value: 0
  is_nullable: 0

=head2 transport

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 255

=head2 backupmx

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

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
  "domain",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "description",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "aliases",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "mailboxes",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "maxquota",
  { data_type => "bigint", default_value => 0, is_nullable => 0 },
  "quota",
  { data_type => "bigint", default_value => 0, is_nullable => 0 },
  "transport",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 255,
  },
  "backupmx",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
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

=item * L</domain>

=back

=cut

__PACKAGE__->set_primary_key("domain");

=head1 RELATIONS

=head2 alias_domain_alias_domain

Type: might_have

Related object: L<PostAdminDB::Schema::Result::AliasDomain>

=cut

__PACKAGE__->might_have(
  "alias_domain_alias_domain",
  "PostAdminDB::Schema::Result::AliasDomain",
  { "foreign.alias_domain" => "self.domain" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 alias_domain_target_domains

Type: has_many

Related object: L<PostAdminDB::Schema::Result::AliasDomain>

=cut

__PACKAGE__->has_many(
  "alias_domain_target_domains",
  "PostAdminDB::Schema::Result::AliasDomain",
  { "foreign.target_domain" => "self.domain" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 aliases

Type: has_many

Related object: L<PostAdminDB::Schema::Result::Alias>

=cut

__PACKAGE__->has_many(
  "aliases",
  "PostAdminDB::Schema::Result::Alias",
  { "foreign.domain" => "self.domain" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 domain_admins

Type: has_many

Related object: L<PostAdminDB::Schema::Result::DomainAdmin>

=cut

__PACKAGE__->has_many(
  "domain_admins",
  "PostAdminDB::Schema::Result::DomainAdmin",
  { "foreign.domain" => "self.domain" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 mailboxes

Type: has_many

Related object: L<PostAdminDB::Schema::Result::Mailbox>

=cut

__PACKAGE__->has_many(
  "mailboxes",
  "PostAdminDB::Schema::Result::Mailbox",
  { "foreign.domain" => "self.domain" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 vacations

Type: has_many

Related object: L<PostAdminDB::Schema::Result::Vacation>

=cut

__PACKAGE__->has_many(
  "vacations",
  "PostAdminDB::Schema::Result::Vacation",
  { "foreign.domain" => "self.domain" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07024 @ 2012-05-21 17:05:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:byVIqwDUMEz7p7dsBwEo6Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
