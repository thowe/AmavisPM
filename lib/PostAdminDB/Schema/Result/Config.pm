use utf8;
package PostAdminDB::Schema::Result::Config;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PostAdminDB::Schema::Result::Config

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

=head1 TABLE: C<config>

=cut

__PACKAGE__->table("config");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'config_id_seq'

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=head2 value

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "config_id_seq",
  },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "value",
  { data_type => "varchar", is_nullable => 0, size => 20 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<config_name_key>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("config_name_key", ["name"]);


# Created by DBIx::Class::Schema::Loader v0.07024 @ 2012-05-21 17:05:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:QTqz+ZD0dZq0ipFmXLqrew


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
