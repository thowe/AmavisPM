use utf8;
package AmavisDB::Schema::Result::Quarantine;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AmavisDB::Schema::Result::Quarantine

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

=head1 TABLE: C<quarantine>

=cut

__PACKAGE__->table("quarantine");

=head1 ACCESSORS

=head2 partition_tag

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 mail_id

  data_type: 'bytea'
  is_foreign_key: 1
  is_nullable: 0

=head2 chunk_ind

  data_type: 'integer'
  is_nullable: 0

=head2 mail_text

  data_type: 'bytea'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "partition_tag",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "mail_id",
  { data_type => "bytea", is_foreign_key => 1, is_nullable => 0 },
  "chunk_ind",
  { data_type => "integer", is_nullable => 0 },
  "mail_text",
  { data_type => "bytea", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</partition_tag>

=item * L</mail_id>

=item * L</chunk_ind>

=back

=cut

__PACKAGE__->set_primary_key("partition_tag", "mail_id", "chunk_ind");

=head1 RELATIONS

=head2 mail

Type: belongs_to

Related object: L<AmavisDB::Schema::Result::Msg>

=cut

__PACKAGE__->belongs_to(
  "mail",
  "AmavisDB::Schema::Result::Msg",
  { mail_id => "mail_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07024 @ 2012-05-25 11:10:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:KJFYT+FtksXVK+NdkAQfjw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
