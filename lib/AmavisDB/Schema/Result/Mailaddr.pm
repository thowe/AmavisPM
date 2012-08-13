use utf8;
package AmavisDB::Schema::Result::Mailaddr;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AmavisDB::Schema::Result::Mailaddr

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

=head1 TABLE: C<mailaddr>

=cut

__PACKAGE__->table("mailaddr");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'mailaddr_id_seq'

=head2 priority

  data_type: 'integer'
  default_value: 9
  is_nullable: 0

=head2 email

  data_type: 'bytea'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "mailaddr_id_seq",
  },
  "priority",
  { data_type => "integer", default_value => 9, is_nullable => 0 },
  "email",
  { data_type => "bytea", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<mailaddr_email_key>

=over 4

=item * L</email>

=back

=cut

__PACKAGE__->add_unique_constraint("mailaddr_email_key", ["email"]);

=head1 RELATIONS

=head2 wblists

Type: has_many

Related object: L<AmavisDB::Schema::Result::Wblist>

=cut

__PACKAGE__->has_many(
  "wblists",
  "AmavisDB::Schema::Result::Wblist",
  { "foreign.sid" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07024 @ 2012-05-25 11:10:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3hhY28qrCF6XPO01wV1JAw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
