use utf8;
package PostAdminDB::Schema::Result::Quota2;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PostAdminDB::Schema::Result::Quota2

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

=head1 TABLE: C<quota2>

=cut

__PACKAGE__->table("quota2");

=head1 ACCESSORS

=head2 username

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 bytes

  data_type: 'bigint'
  default_value: 0
  is_nullable: 0

=head2 messages

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "username",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "bytes",
  { data_type => "bigint", default_value => 0, is_nullable => 0 },
  "messages",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</username>

=back

=cut

__PACKAGE__->set_primary_key("username");


# Created by DBIx::Class::Schema::Loader v0.07024 @ 2012-05-21 17:05:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:cOKgYaqfnbAw7qAA7VO5dg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
