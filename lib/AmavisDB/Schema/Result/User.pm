use utf8;
package AmavisDB::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AmavisDB::Schema::Result::User

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

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'users_id_seq'

=head2 priority

  data_type: 'integer'
  default_value: 7
  is_nullable: 0

=head2 policy_id

  data_type: 'integer'
  default_value: 1
  is_foreign_key: 1
  is_nullable: 0

=head2 email

  data_type: 'bytea'
  is_nullable: 0

=head2 fullname

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "users_id_seq",
  },
  "priority",
  { data_type => "integer", default_value => 7, is_nullable => 0 },
  "policy_id",
  {
    data_type      => "integer",
    default_value  => 1,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "email",
  { data_type => "bytea", is_nullable => 0 },
  "fullname",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 255,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<users_email_key>

=over 4

=item * L</email>

=back

=cut

__PACKAGE__->add_unique_constraint("users_email_key", ["email"]);

=head1 RELATIONS

=head2 policy

Type: belongs_to

Related object: L<AmavisDB::Schema::Result::Policy>

=cut

__PACKAGE__->belongs_to(
  "policy",
  "AmavisDB::Schema::Result::Policy",
  { id => "policy_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 wblists

Type: has_many

Related object: L<AmavisDB::Schema::Result::Wblist>

=cut

__PACKAGE__->has_many(
  "wblists",
  "AmavisDB::Schema::Result::Wblist",
  { "foreign.rid" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07024 @ 2012-05-25 11:10:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/hEoMv8CtC9hFmEfGBHJSQ

=head2 whitelisted

Type: has_many

Related object:  L<AmavisDB::Schema::Result::Wblist>

Only returns where wb is 'W'.

=cut

__PACKAGE__->has_many(
  'whitelisted' => 'AmavisDB::Schema::Result::Wblist',
  sub {
    my $args = shift;

    return {
        "$args->{foreign_alias}.rid" => { -ident => "$args->{self_alias}.id" },
        "$args->{foreign_alias}.wb"  => 'W',
    };
  }
);

__PACKAGE__->has_many(
  'blacklisted' => 'AmavisDB::Schema::Result::Wblist',
  sub {
    my $args = shift;

    return {
        "$args->{foreign_alias}.rid" => { -ident => "$args->{self_alias}.id" },
        "$args->{foreign_alias}.wb"  => 'B',
    };
  }
);

__PACKAGE__->many_to_many( 'whitelisted_addresses' => 'whitelisted', 'sid' );

__PACKAGE__->many_to_many( 'blacklisted_addresses' => 'blacklisted', 'sid' );

1;
