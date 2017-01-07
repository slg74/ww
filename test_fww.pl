#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use File::Basename qw(dirname);
use Cwd qw(abs_path);
use lib dirname(dirname abs_path $0) . '/lib';

use My::ww qw(get_wwritable_files unset_wwritable); 


BEGIN { use_ok("My::ww") }
can_ok("My::ww", "get_wwritable_files");
can_ok("My::ww", "unset_wwritable");

mkdir "/tmp/test";

chmod 0777, "/tmp/test/*"; 

my $dir = "/tmp/test";
my $verbose = 0;

my $fww = My::ww::get_wwritable_files($dir, $verbose);
my $uww = My::ww::unset_wwritable($dir, $verbose);

done_testing;
