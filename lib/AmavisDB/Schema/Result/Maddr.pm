use utf8;
package AmavisDB::Schema::Result::Maddr;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AmavisDB::Schema::Result::Maddr

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

=head1 TABLE: C<maddr>

=cut

__PACKAGE__->table("maddr");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'maddr_id_seq'

=head2 partition_tag

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 email

  data_type: 'bytea'
  is_nullable: 0

=head2 domain

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "maddr_id_seq",
  },
  "partition_tag",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "email",
  { data_type => "bytea", is_nullable => 0 },
  "domain",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<part_email>

=over 4

=item * L</partition_tag>

=item * L</email>

=back

=cut

__PACKAGE__->add_unique_constraint("part_email", ["partition_tag", "email"]);

=head1 RELATIONS

=head2 msgrcpts

Type: has_many

Related object: L<AmavisDB::Schema::Result::Msgrcpt>

=cut

__PACKAGE__->has_many(
  "msgrcpts",
  "AmavisDB::Schema::Result::Msgrcpt",
  { "foreign.rid" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 msgs

Type: has_many

Related object: L<AmavisDB::Schema::Result::Msg>

=cut

__PACKAGE__->has_many(
  "msgs",
  "AmavisDB::Schema::Result::Msg",
  { "foreign.sid" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07024 @ 2012-05-25 11:10:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:8AInlQdMtPhS+M+4n6oPwA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
