#!perl
use strict;
use warnings;
use Template::ShowStartStop;
use Template::Test;

my $tt = Template->new({
	CONTEXT => Template::ShowStartStop->new
});

$tt::Test::DEBUG = 1;

my $vars = {
	var => 'world',
};

test_expect(\*DATA, $tt, $vars);

__DATA__
--test--
hello [% var %]
--expect--
<!-- START: process input text -->
hello world
<!-- STOP:  process input text -->
