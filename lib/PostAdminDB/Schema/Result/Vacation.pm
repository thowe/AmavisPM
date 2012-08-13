use utf8;
package PostAdminDB::Schema::Result::Vacation;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PostAdminDB::Schema::Result::Vacation

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

=head1 TABLE: C<vacation>

=cut

__PACKAGE__->table("vacation");

=head1 ACCESSORS

=head2 email

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 subject

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 body

  data_type: 'text'
  default_value: (empty string)
  is_nullable: 0

=head2 created

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=head2 active

  data_type: 'boolean'
  default_value: true
  is_nullable: 0

=head2 domain

  data_type: 'varchar'
  is_foreign_key: 1
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "email",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "subject",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "body",
  { data_type => "text", default_value => "", is_nullable => 0 },
  "created",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 1,
    original      => { default_value => \"now()" },
  },
  "active",
  { data_type => "boolean", default_value => \"true", is_nullable => 0 },
  "domain",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</email>

=back

=cut

__PACKAGE__->set_primary_key("email");

=head1 RELATIONS

=head2 domain

Type: belongs_to

Related object: L<PostAdminDB::Schema::Result::Domain>

=cut

__PACKAGE__->belongs_to(
  "domain",
  "PostAdminDB::Schema::Result::Domain",
  { domain => "domain" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 vacation_notifications

Type: has_many

Related object: L<PostAdminDB::Schema::Result::VacationNotification>

=cut

__PACKAGE__->has_many(
  "vacation_notifications",
  "PostAdminDB::Schema::Result::VacationNotification",
  { "foreign.on_vacation" => "self.email" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07024 @ 2012-05-21 17:05:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:RI8bk/VPBOx/8wXqZ+6d0Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
