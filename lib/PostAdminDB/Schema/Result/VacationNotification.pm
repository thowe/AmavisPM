use utf8;
package PostAdminDB::Schema::Result::VacationNotification;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PostAdminDB::Schema::Result::VacationNotification

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

=head1 TABLE: C<vacation_notification>

=cut

__PACKAGE__->table("vacation_notification");

=head1 ACCESSORS

=head2 on_vacation

  data_type: 'varchar'
  is_foreign_key: 1
  is_nullable: 0
  size: 255

=head2 notified

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 notified_at

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=cut

__PACKAGE__->add_columns(
  "on_vacation",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 0, size => 255 },
  "notified",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "notified_at",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</on_vacation>

=item * L</notified>

=back

=cut

__PACKAGE__->set_primary_key("on_vacation", "notified");

=head1 RELATIONS

=head2 on_vacation

Type: belongs_to

Related object: L<PostAdminDB::Schema::Result::Vacation>

=cut

__PACKAGE__->belongs_to(
  "on_vacation",
  "PostAdminDB::Schema::Result::Vacation",
  { email => "on_vacation" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07024 @ 2012-05-21 17:05:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:+mihit55JvJJKhFNhx+DRA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
