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

my $final_output = <<END;
<!-- START: process input file handle -->
hello world
<!-- STOP:  process input file handle -->
END

my $output = \do{ my $i }; #use anonymous scalar

ok( $tt->process(\*DATA, $vars, $output), 'process template');

is( $$output, $final_output, 'test hello world output');

done_testing();
__DATA__
hello [% var %]
