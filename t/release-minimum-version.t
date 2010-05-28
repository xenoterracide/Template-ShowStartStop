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

eval "use Test::MinimumVersion";
plan skip_all => "Test::MinimumVersion required for testing minimum versions"
  if $@;
all_minimum_version_from_metayml_ok();