#!perl -Tw

use strict;
use warnings;

use Test::More tests => 2;

BEGIN {
    use_ok( 'Template::Timer' );
}

my $tt =
    Template->new( {
        CONTEXT => Template::Timer->new
    } );

my $block = "[% thing = 'doohickey' %]";

TODO: { # See RT # 13225
    local $TODO = "Problem identified but not fixed";
    my $rc = $tt->process( \*DATA, { block => $block } );
    ok( $rc, 'eval' );
}

__DATA__
[% block | eval %]
[% thing %]
