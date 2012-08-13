use utf8;
package PostAdminDB::Schema::Result::Admin;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PostAdminDB::Schema::Result::Admin - Postfix Admin - Virtual Admins

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

=head1 TABLE: C<admin>

=cut

__PACKAGE__->table("admin");

=head1 ACCESSORS

=head2 username

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 password

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 created

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=head2 modified

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=head2 active

  data_type: 'boolean'
  default_value: true
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "username",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "password",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "created",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 1,
    original      => { default_value => \"now()" },
  },
  "modified",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 1,
    original      => { default_value => \"now()" },
  },
  "active",
  { data_type => "boolean", default_value => \"true", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</username>

=back

=cut

__PACKAGE__->set_primary_key("username");


# Created by DBIx::Class::Schema::Loader v0.07024 @ 2012-05-21 17:05:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ClRivztjaJpnc1cuzA7bfg

__PACKAGE__->has_many(
  "domain_admins",
  "PostAdminDB::Schema::Result::DomainAdmin",
  { "foreign.username" => "self.username" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->many_to_many( 'domains' => 'domain_admins', 'domain' );

#use Crypt::PasswdMD5 qw( unix_md5_crypt );
use Digest::MD5 qw( md5_hex );

=head2 check_password

Check if the passwords match the database password.

=cut

sub check_password {
    my ( $self, $clearpw ) = @_;
    my $cryptpw;
    print $self->result_source->schema->encrypt;

    if( $self->result_source->schema->encrypt eq 'md5' ) {
        $cryptpw = md5_hex( $clearpw );
    }
    return $cryptpw eq $self->password;
}

1;
