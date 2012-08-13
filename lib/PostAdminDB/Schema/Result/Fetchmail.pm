use utf8;
package PostAdminDB::Schema::Result::Fetchmail;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PostAdminDB::Schema::Result::Fetchmail

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

=head1 TABLE: C<fetchmail>

=cut

__PACKAGE__->table("fetchmail");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'fetchmail_id_seq'

=head2 mailbox

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 src_server

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 src_auth

  data_type: 'varchar'
  is_nullable: 0
  size: 15

=head2 src_user

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 src_password

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 src_folder

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 poll_time

  data_type: 'integer'
  default_value: 10
  is_nullable: 0

=head2 fetchall

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=head2 keep

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=head2 protocol

  data_type: 'varchar'
  is_nullable: 0
  size: 15

=head2 extra_options

  data_type: 'text'
  is_nullable: 1

=head2 returned_text

  data_type: 'text'
  is_nullable: 1

=head2 mda

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 date

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=head2 usessl

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "fetchmail_id_seq",
  },
  "mailbox",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "src_server",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "src_auth",
  { data_type => "varchar", is_nullable => 0, size => 15 },
  "src_user",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "src_password",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "src_folder",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "poll_time",
  { data_type => "integer", default_value => 10, is_nullable => 0 },
  "fetchall",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
  "keep",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
  "protocol",
  { data_type => "varchar", is_nullable => 0, size => 15 },
  "extra_options",
  { data_type => "text", is_nullable => 1 },
  "returned_text",
  { data_type => "text", is_nullable => 1 },
  "mda",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "date",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 1,
    original      => { default_value => \"now()" },
  },
  "usessl",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07024 @ 2012-05-21 17:05:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:rHjmP2HfZTY+CzqfVdr7/A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
