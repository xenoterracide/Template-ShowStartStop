#!perl -T
use strict;
use warnings;

use Test::More;

BEGIN { use_ok( 'Template' ); }
BEGIN { use_ok( 'Template::ShowStartStop' ); }

my $tt = Template->new({
	CONTEXT => Template::ShowStartStop->new
});

my $vars = {
	var => 'world',
};

test_expect(\*DATA, $tt, $vars);

__DATA__
--test--
hello [% var %]
--expect--
<!-- START: process input file handle -->
hello world
<!-- STOP:  process input file handle -->
