#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Superglue' );
}

diag( "Testing Superglue $Superglue::VERSION, Perl $], $^X" );
