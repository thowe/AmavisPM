use utf8;
package PostAdminDB::Schema;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;


# Created by DBIx::Class::Schema::Loader v0.07024 @ 2012-05-21 17:05:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5jYd0R8Hup+CRmTU2omyZQ

# to use the Mailbox data in the conf file
__PACKAGE__->mk_group_accessors( simple => qw/encrypt/);

1;
