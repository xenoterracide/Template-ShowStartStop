#!perl
use strict;
use warnings;
use Template::ShowStartStop;
use Template::Test;

my $tt = Template->new({
	CONTEXT => Template::ShowStartStop->new,
});

my $vars = {
	var => 'world',
};

test_expect(\*DATA, $tt, $vars);

__DATA__
--test--
[% WRAPPER t/templates/wrapper.tt -%]
hello [% var %]
[% END -%]
[% PROCESS t/templates/how.tt -%]
--expect--
<!-- START: process input text -->
<!-- START: process wrapper.tt -->
Well,
hello world
<!-- STOP:  process t/templates/wrapper.tt -->
<!-- START: process t/templates/how.tt -->
How are you today?
<!-- STOP:  process t/templates/how.tt -->
<!-- STOP:  process input text -->
