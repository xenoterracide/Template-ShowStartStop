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
	fragment => "The cat sat on the [% place %]",
};
my $block = q{[% thing = 'doohickey' %]};

test_expect(\*DATA, $tt, $vars);

#TODO: { # See RT # 13225
#    local $TODO = 'Problem identified but not fixed';
#    my $rc = $tt->process( \*DATA, { block => $block } );
#    ok( $rc, 'eval' );
#}
__DATA__
-- test --
[% fragment | eval %]
