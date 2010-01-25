use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Template::Timer',
    AUTHOR              => 'Andy Lester <andy@petdance.com>',
    VERSION_FROM        => 'Timer.pm',
    ABSTRACT_FROM       => 'Timer.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Template'      => 0,
        'Test::More'    => 0,
        'Time::HiRes'   => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Template-Timer-*' },
);
