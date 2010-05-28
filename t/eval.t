#!perl
use strict;
use warnings;
use Template::ShowStartStop;
use Template::Test;

$Template::Test::DEBUG = 1;

my $tt = Template->new({
	CONTEXT => Template::ShowStartStop->new,
});

my $vars = {
	place => 'hat',
	fragment => "The cat sat on the [% place %]",
};

test_expect(\*DATA, $tt, $vars);

__DATA__
-- test --
[% fragment | eval %]
-- expect --
The cat sat on the hat
