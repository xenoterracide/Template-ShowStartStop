#!perl
use strict;
use warnings;
use Template::ShowStartStop;
use Template::Test;
$Template::Test::DEBUG = 1;

my $tt = Template->new({
	CONTEXT => Template::ShowStartStop->new
});

my $vars = {
	var => 'world',
};

test_expect(\*DATA, $tt, $vars);

__DATA__
-- test --
-- hello.tt --
hello [% var %]
-- expect --
<!-- START: process hello.tt -->
hello world
<!-- STOP:  process hello.tt -->
