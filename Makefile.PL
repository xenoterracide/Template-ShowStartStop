
use strict;
use warnings;



use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
                       'test' => {
                                   'TESTS' => 't/*.t'
                                 },
                       'NAME' => 'Template::ShowStartStop',
                       'DISTNAME' => 'Template-ShowStartStop',
                       'CONFIGURE_REQUIRES' => {
                                                 'ExtUtils::MakeMaker' => '6.31'
                                               },
                       'AUTHOR' => 'Caleb Cushing <xenoterracide@gmail.com>',
                       'BUILD_REQUIRES' => {
                                             'Test::More' => '0.88',
                                             'Scalar::Util' => '0',
                                             'perl' => '5.004',
                                             'Carp' => '0'
                                           },
                       'ABSTRACT' => 'Display where template\'s start and stop',
                       'EXE_FILES' => [],
                       'VERSION' => '0.06',
                       'PREREQ_PM' => {
                                        'parent' => '0',
                                        'Template::Context' => '0'
                                      },
                       'LICENSE' => 'perl'
                     );


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM}; 
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod}; 
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



