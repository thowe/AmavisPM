use strict;
use warnings;
use Test::More;


use Catalyst::Test 'AmavisPM';
use AmavisPM::Controller::Domain;

ok( request('/domain')->is_success, 'Request should succeed' );
done_testing();
