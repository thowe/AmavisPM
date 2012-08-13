use strict;
use warnings;

use AmavisPM;

my $app = AmavisPM->apply_default_middlewares(AmavisPM->psgi_app);
$app;

