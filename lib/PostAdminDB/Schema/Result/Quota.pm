use utf8;
package PostAdminDB::Schema::Result::Quota;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PostAdminDB::Schema::Result::Quota

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

=head1 TABLE: C<quota>

=cut

__PACKAGE__->table("quota");

=head1 ACCESSORS

=head2 username

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 path

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 current

  data_type: 'bigint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "username",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "path",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "current",
  { data_type => "bigint", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</username>

=item * L</path>

=back

=cut

__PACKAGE__->set_primary_key("username", "path");


# Created by DBIx::Class::Schema::Loader v0.07024 @ 2012-05-21 17:05:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:yOKcE9hRbqCg17YmVwKBKA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
