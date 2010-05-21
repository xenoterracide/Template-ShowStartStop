#!perl -T

use strict;
use warnings;

use Test::More tests => 3;

BEGIN { use_ok( 'Template' ); }
BEGIN { use_ok( 'Template::ShowStartStop' ); }

my $tt =
    Template->new( {
        CONTEXT => Template::ShowStartStop->new
    } );

my $block = q{[% thing = 'doohickey' %]};

TODO: { # See RT # 13225
    local $TODO = 'Problem identified but not fixed';
    my $rc = $tt->process( \*DATA, { block => $block } );
    ok( $rc, 'eval' );
}

__DATA__
[% block | eval %]
[% thing %]
