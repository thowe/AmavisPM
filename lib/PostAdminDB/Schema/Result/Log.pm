use utf8;
package PostAdminDB::Schema::Result::Log;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PostAdminDB::Schema::Result::Log - Postfix Admin - Log

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

=head1 TABLE: C<log>

=cut

__PACKAGE__->table("log");

=head1 ACCESSORS

=head2 timestamp

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=head2 username

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 domain

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 action

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 data

  data_type: 'text'
  default_value: (empty string)
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "timestamp",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 1,
    original      => { default_value => \"now()" },
  },
  "username",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "domain",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "action",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "data",
  { data_type => "text", default_value => "", is_nullable => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07024 @ 2012-05-21 17:05:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2Q3oWcbn02EW9q3UMx0Ihw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
