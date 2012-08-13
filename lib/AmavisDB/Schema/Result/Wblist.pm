use utf8;
package AmavisDB::Schema::Result::Wblist;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AmavisDB::Schema::Result::Wblist

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

=head1 TABLE: C<wblist>

=cut

__PACKAGE__->table("wblist");

=head1 ACCESSORS

=head2 rid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 sid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 wb

  data_type: 'varchar'
  is_nullable: 0
  size: 10

=cut

__PACKAGE__->add_columns(
  "rid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "sid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "wb",
  { data_type => "varchar", is_nullable => 0, size => 10 },
);

=head1 PRIMARY KEY

=over 4

=item * L</rid>

=item * L</sid>

=back

=cut

__PACKAGE__->set_primary_key("rid", "sid");

=head1 RELATIONS

=head2 rid

Type: belongs_to

Related object: L<AmavisDB::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "rid",
  "AmavisDB::Schema::Result::User",
  { id => "rid" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 sid

Type: belongs_to

Related object: L<AmavisDB::Schema::Result::Mailaddr>

=cut

__PACKAGE__->belongs_to(
  "sid",
  "AmavisDB::Schema::Result::Mailaddr",
  { id => "sid" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07024 @ 2012-05-25 11:10:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:XXqijEu5Pvr9sSECCHb7KQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
