use utf8;
package AmavisDB::Schema::Result::Msgrcpt;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AmavisDB::Schema::Result::Msgrcpt

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

=head1 TABLE: C<msgrcpt>

=cut

__PACKAGE__->table("msgrcpt");

=head1 ACCESSORS

=head2 partition_tag

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 mail_id

  data_type: 'bytea'
  is_foreign_key: 1
  is_nullable: 0

=head2 rseqnum

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 rid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 is_local

  data_type: 'char'
  default_value: ' '
  is_nullable: 0
  size: 1

=head2 content

  data_type: 'char'
  default_value: ' '
  is_nullable: 0
  size: 1

=head2 ds

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 rs

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 bl

  data_type: 'char'
  default_value: ' '
  is_nullable: 1
  size: 1

=head2 wl

  data_type: 'char'
  default_value: ' '
  is_nullable: 1
  size: 1

=head2 bspam_level

  data_type: 'real'
  is_nullable: 1

=head2 smtp_resp

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "partition_tag",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "mail_id",
  { data_type => "bytea", is_foreign_key => 1, is_nullable => 0 },
  "rseqnum",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "rid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "is_local",
  { data_type => "char", default_value => " ", is_nullable => 0, size => 1 },
  "content",
  { data_type => "char", default_value => " ", is_nullable => 0, size => 1 },
  "ds",
  { data_type => "char", is_nullable => 0, size => 1 },
  "rs",
  { data_type => "char", is_nullable => 0, size => 1 },
  "bl",
  { data_type => "char", default_value => " ", is_nullable => 1, size => 1 },
  "wl",
  { data_type => "char", default_value => " ", is_nullable => 1, size => 1 },
  "bspam_level",
  { data_type => "real", is_nullable => 1 },
  "smtp_resp",
  { data_type => "varchar", default_value => "", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</partition_tag>

=item * L</mail_id>

=item * L</rseqnum>

=back

=cut

__PACKAGE__->set_primary_key("partition_tag", "mail_id", "rseqnum");

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

=head2 rid

Type: belongs_to

Related object: L<AmavisDB::Schema::Result::Maddr>

=cut

__PACKAGE__->belongs_to(
  "rid",
  "AmavisDB::Schema::Result::Maddr",
  { id => "rid" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07024 @ 2012-05-25 11:10:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0tDOAnClEADLBgTfCaX5+w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
