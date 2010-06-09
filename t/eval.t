#!perl
#
# This file is part of Template-ShowStartStop
#
# This software is Copyright (c) 2010 by Caleb Cushing.
#
# This is free software, licensed under:
#
#   The Artistic License 2.0
#
use strict;
use warnings;
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
	fragment => "The cat sat on the [% place %]\n",
};

test_expect(\*DATA, $tt, $vars);

__DATA__
-- test --
[% fragment | eval -%]
-- expect --
<!-- START: process input text -->
<!-- START: process (evaluated block) -->
The cat sat on the hat
<!-- STOP:  process (evaluated block) -->
<!-- STOP:  process input text -->
