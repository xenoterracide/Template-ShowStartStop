use strict;
use warnings;
use ExtUtils::MakeMaker;

my %parms = (
    NAME                => 'Template::ShowStartStop',
    AUTHOR              => 'Caleb Cushing <xenoterracide@gmail.com>',
    VERSION_FROM        => 'ShowStartStop.pm',
    ABSTRACT_FROM       => 'ShowStartStop.pm',
    PL_FILES            => {},
    PREREQ_PM => {
		'parent'		=> 0,
        'Template'      => 0,
        'Test::More'    => 0,
        'Time::HiRes'   => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Template-ShowStartStop-*' },
);

if ( $ExtUtils::MakeMaker::VERSION ge '6.36' ) {
    $parms{EXTRA_META} = <<EOF;
resources:
    license: http://dev.perl.org/licenses/
    Repository: http://github.com/xenoterracide/template-showstartstop/
EOF
}


WriteMakefile( %parms );

sub MY::postamble {
    my $postamble = <<'MAKE_FRAG';
.PHONY: tags critic

tags:
	ctags -f tags --recurse --totals \
		--exclude=blib \
		--exclude=.svn \
		--exclude='*~' \
		--languages=Perl --langmap=Perl:+.t \

critic:
	perlcritic -1 -q -profile perlcriticrc ShowStartStop.pm t/*.t

MAKE_FRAG

    return $postamble;
}
