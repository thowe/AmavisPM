use utf8;
package AmavisDB::Schema::Result::Msg;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AmavisDB::Schema::Result::Msg

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

=head1 TABLE: C<msgs>

=cut

__PACKAGE__->table("msgs");

=head1 ACCESSORS

=head2 partition_tag

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 mail_id

  data_type: 'bytea'
  is_nullable: 0

=head2 secret_id

  data_type: 'bytea'
  default_value: '\x'
  is_nullable: 1

=head2 am_id

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=head2 time_num

  data_type: 'integer'
  is_nullable: 0

=head2 time_iso

  data_type: 'timestamp with time zone'
  is_nullable: 0

=head2 sid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 policy

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 1
  size: 255

=head2 client_addr

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 1
  size: 255

=head2 size

  data_type: 'integer'
  is_nullable: 0

=head2 originating

  data_type: 'char'
  default_value: ' '
  is_nullable: 0
  size: 1

=head2 content

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 quar_type

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 quar_loc

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 1
  size: 255

=head2 dsn_sent

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 spam_level

  data_type: 'real'
  is_nullable: 1

=head2 message_id

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 1
  size: 255

=head2 from_addr

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 1
  size: 255

=head2 subject

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 1
  size: 255

=head2 host

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "partition_tag",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "mail_id",
  { data_type => "bytea", is_nullable => 0 },
  "secret_id",
  { data_type => "bytea", default_value => "\\x", is_nullable => 1 },
  "am_id",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "time_num",
  { data_type => "integer", is_nullable => 0 },
  "time_iso",
  { data_type => "timestamp with time zone", is_nullable => 0 },
  "sid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "policy",
  { data_type => "varchar", default_value => "", is_nullable => 1, size => 255 },
  "client_addr",
  { data_type => "varchar", default_value => "", is_nullable => 1, size => 255 },
  "size",
  { data_type => "integer", is_nullable => 0 },
  "originating",
  { data_type => "char", default_value => " ", is_nullable => 0, size => 1 },
  "content",
  { data_type => "char", is_nullable => 1, size => 1 },
  "quar_type",
  { data_type => "char", is_nullable => 1, size => 1 },
  "quar_loc",
  { data_type => "varchar", default_value => "", is_nullable => 1, size => 255 },
  "dsn_sent",
  { data_type => "char", is_nullable => 1, size => 1 },
  "spam_level",
  { data_type => "real", is_nullable => 1 },
  "message_id",
  { data_type => "varchar", default_value => "", is_nullable => 1, size => 255 },
  "from_addr",
  { data_type => "varchar", default_value => "", is_nullable => 1, size => 255 },
  "subject",
  { data_type => "varchar", default_value => "", is_nullable => 1, size => 255 },
  "host",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</partition_tag>

=item * L</mail_id>

=back

=cut

__PACKAGE__->set_primary_key("partition_tag", "mail_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<msgs_mail_id_key>

=over 4

=item * L</mail_id>

=back

=cut

__PACKAGE__->add_unique_constraint("msgs_mail_id_key", ["mail_id"]);

=head1 RELATIONS

=head2 msgrcpts

Type: has_many

Related object: L<AmavisDB::Schema::Result::Msgrcpt>

=cut

__PACKAGE__->has_many(
  "msgrcpts",
  "AmavisDB::Schema::Result::Msgrcpt",
  { "foreign.mail_id" => "self.mail_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 quarantines

Type: has_many

Related object: L<AmavisDB::Schema::Result::Quarantine>

=cut

__PACKAGE__->has_many(
  "quarantines",
  "AmavisDB::Schema::Result::Quarantine",
  { "foreign.mail_id" => "self.mail_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 sid

Type: belongs_to

Related object: L<AmavisDB::Schema::Result::Maddr>

=cut

__PACKAGE__->belongs_to(
  "sid",
  "AmavisDB::Schema::Result::Maddr",
  { id => "sid" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07024 @ 2012-05-25 11:10:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:YH4Fg1WCEQoNpAWCncqH0A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
