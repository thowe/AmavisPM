use utf8;
package AmavisDB::Schema::Result::Policy;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AmavisDB::Schema::Result::Policy

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

=head1 TABLE: C<policy>

=cut

__PACKAGE__->table("policy");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'policy_id_seq'

=head2 policy_name

  data_type: 'varchar'
  is_nullable: 1
  size: 32

=head2 virus_lover

  data_type: 'char'
  default_value: null
  is_nullable: 1
  size: 1

=head2 spam_lover

  data_type: 'char'
  default_value: null
  is_nullable: 1
  size: 1

=head2 unchecked_lover

  data_type: 'char'
  default_value: null
  is_nullable: 1
  size: 1

=head2 banned_files_lover

  data_type: 'char'
  default_value: null
  is_nullable: 1
  size: 1

=head2 bad_header_lover

  data_type: 'char'
  default_value: null
  is_nullable: 1
  size: 1

=head2 bypass_virus_checks

  data_type: 'char'
  default_value: null
  is_nullable: 1
  size: 1

=head2 bypass_spam_checks

  data_type: 'char'
  default_value: null
  is_nullable: 1
  size: 1

=head2 bypass_banned_checks

  data_type: 'char'
  default_value: null
  is_nullable: 1
  size: 1

=head2 bypass_header_checks

  data_type: 'char'
  default_value: null
  is_nullable: 1
  size: 1

=head2 virus_quarantine_to

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 64

=head2 spam_quarantine_to

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 64

=head2 banned_quarantine_to

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 64

=head2 unchecked_quarantine_to

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 64

=head2 bad_header_quarantine_to

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 64

=head2 clean_quarantine_to

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 64

=head2 archive_quarantine_to

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 64

=head2 spam_tag_level

  data_type: 'real'
  is_nullable: 1

=head2 spam_tag2_level

  data_type: 'real'
  is_nullable: 1

=head2 spam_tag3_level

  data_type: 'real'
  is_nullable: 1

=head2 spam_kill_level

  data_type: 'real'
  is_nullable: 1

=head2 spam_dsn_cutoff_level

  data_type: 'real'
  is_nullable: 1

=head2 spam_quarantine_cutoff_level

  data_type: 'real'
  is_nullable: 1

=head2 addr_extension_virus

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 64

=head2 addr_extension_spam

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 64

=head2 addr_extension_banned

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 64

=head2 addr_extension_bad_header

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 64

=head2 warnvirusrecip

  data_type: 'char'
  default_value: null
  is_nullable: 1
  size: 1

=head2 warnbannedrecip

  data_type: 'char'
  default_value: null
  is_nullable: 1
  size: 1

=head2 warnbadhrecip

  data_type: 'char'
  default_value: null
  is_nullable: 1
  size: 1

=head2 newvirus_admin

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 64

=head2 virus_admin

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 64

=head2 banned_admin

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 64

=head2 bad_header_admin

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 64

=head2 spam_admin

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 64

=head2 spam_subject_tag

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 64

=head2 spam_subject_tag2

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 64

=head2 spam_subject_tag3

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 64

=head2 message_size_limit

  data_type: 'integer'
  is_nullable: 1

=head2 banned_rulenames

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 64

=head2 disclaimer_options

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 64

=head2 forward_method

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 64

=head2 sa_userconf

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 64

=head2 sa_username

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 64

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "policy_id_seq",
  },
  "policy_name",
  { data_type => "varchar", is_nullable => 1, size => 32 },
  "virus_lover",
  { data_type => "char", default_value => \"null", is_nullable => 1, size => 1 },
  "spam_lover",
  { data_type => "char", default_value => \"null", is_nullable => 1, size => 1 },
  "unchecked_lover",
  { data_type => "char", default_value => \"null", is_nullable => 1, size => 1 },
  "banned_files_lover",
  { data_type => "char", default_value => \"null", is_nullable => 1, size => 1 },
  "bad_header_lover",
  { data_type => "char", default_value => \"null", is_nullable => 1, size => 1 },
  "bypass_virus_checks",
  { data_type => "char", default_value => \"null", is_nullable => 1, size => 1 },
  "bypass_spam_checks",
  { data_type => "char", default_value => \"null", is_nullable => 1, size => 1 },
  "bypass_banned_checks",
  { data_type => "char", default_value => \"null", is_nullable => 1, size => 1 },
  "bypass_header_checks",
  { data_type => "char", default_value => \"null", is_nullable => 1, size => 1 },
  "virus_quarantine_to",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 64,
  },
  "spam_quarantine_to",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 64,
  },
  "banned_quarantine_to",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 64,
  },
  "unchecked_quarantine_to",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 64,
  },
  "bad_header_quarantine_to",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 64,
  },
  "clean_quarantine_to",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 64,
  },
  "archive_quarantine_to",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 64,
  },
  "spam_tag_level",
  { data_type => "real", is_nullable => 1 },
  "spam_tag2_level",
  { data_type => "real", is_nullable => 1 },
  "spam_tag3_level",
  { data_type => "real", is_nullable => 1 },
  "spam_kill_level",
  { data_type => "real", is_nullable => 1 },
  "spam_dsn_cutoff_level",
  { data_type => "real", is_nullable => 1 },
  "spam_quarantine_cutoff_level",
  { data_type => "real", is_nullable => 1 },
  "addr_extension_virus",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 64,
  },
  "addr_extension_spam",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 64,
  },
  "addr_extension_banned",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 64,
  },
  "addr_extension_bad_header",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 64,
  },
  "warnvirusrecip",
  { data_type => "char", default_value => \"null", is_nullable => 1, size => 1 },
  "warnbannedrecip",
  { data_type => "char", default_value => \"null", is_nullable => 1, size => 1 },
  "warnbadhrecip",
  { data_type => "char", default_value => \"null", is_nullable => 1, size => 1 },
  "newvirus_admin",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 64,
  },
  "virus_admin",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 64,
  },
  "banned_admin",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 64,
  },
  "bad_header_admin",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 64,
  },
  "spam_admin",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 64,
  },
  "spam_subject_tag",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 64,
  },
  "spam_subject_tag2",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 64,
  },
  "spam_subject_tag3",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 64,
  },
  "message_size_limit",
  { data_type => "integer", is_nullable => 1 },
  "banned_rulenames",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 64,
  },
  "disclaimer_options",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 64,
  },
  "forward_method",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 64,
  },
  "sa_userconf",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 64,
  },
  "sa_username",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 64,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 users

Type: has_many

Related object: L<AmavisDB::Schema::Result::User>

=cut

__PACKAGE__->has_many(
  "users",
  "AmavisDB::Schema::Result::User",
  { "foreign.policy_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07024 @ 2012-05-25 11:10:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:kS4uuZTjz6tFbnz/WYTXzA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
