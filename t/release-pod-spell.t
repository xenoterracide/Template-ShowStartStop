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

BEGIN {
  unless ($ENV{RELEASE_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for release candidate testing');
  }
}


use Test::More;

eval "use Pod::Wordlist::hanekomu";
plan skip_all => "Pod::Wordlist:hanekomu required for testing POD spelling"
  if $@;

eval "use Test::Spelling";
plan skip_all => "Test::Spelling required for testing POD spelling"
  if $@;

all_pod_files_spelling_ok('lib');