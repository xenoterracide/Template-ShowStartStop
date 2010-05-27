#!perl
use strict;
use warnings;
use Template::ShowStartStop;
use Template::Test;

my $tt = Template->new({
	CONTEXT => Template::ShowStartStop->new,
	RELATIVE => 1,
});

my $vars = {
	var => 'world',
};

test_expect(\*DATA, $tt, $vars);

__DATA__
--test--
hello [% var %]
[% INSERT ./templates/how.tt -%]
--expect--
<!-- START: process input text -->
hello world
How are you today?
<!-- STOP:  process input text -->
