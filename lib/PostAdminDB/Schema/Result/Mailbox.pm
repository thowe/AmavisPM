use utf8;
package PostAdminDB::Schema::Result::Mailbox;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PostAdminDB::Schema::Result::Mailbox - Postfix Admin - Virtual Mailboxes

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

=head1 TABLE: C<mailbox>

=cut

__PACKAGE__->table("mailbox");

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

=head2 name

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 maildir

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 quota

  data_type: 'bigint'
  default_value: 0
  is_nullable: 0

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

=head2 domain

  data_type: 'varchar'
  is_foreign_key: 1
  is_nullable: 1
  size: 255

=head2 local_part

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "username",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "password",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "name",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "maildir",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "quota",
  { data_type => "bigint", default_value => 0, is_nullable => 0 },
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
  "domain",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 1, size => 255 },
  "local_part",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</username>

=back

=cut

__PACKAGE__->set_primary_key("username");

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


# Created by DBIx::Class::Schema::Loader v0.07024 @ 2012-05-21 17:05:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1nadoZ67dWLpAu+2Xm1bFw

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
