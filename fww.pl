#!/usr/bin/perl

use strict;
use warnings; 
use File::Basename qw(dirname);
use Cwd qw(abs_path);
use lib dirname(dirname abs_path $0) . '/lib';

use My::ww qw(get_wwritable_files unset_wwritable); 

sub check_user {
	my $username = getpwuid($<);
	if ($username !~ "root") {
		print "Must run as root or via sudo. Exiting.\n";
		exit 1;
	}
}

check_user(); 

my $args = @ARGV;

if (!$args) {
	print "Usage: ./fww.pl [dir] [--verbose]\n"; 
	print "       ./fww.pl /tmp --verbose\n"; 
	print " -or-  ./fww.pl /tmp\n"; 
	exit 1;
}

my ($dir, $verbose) = @ARGV;

if (!$dir) {
	print "No directory supplied. Exiting.\n";
	exit 1;
}

if ($dir and !$verbose) {
	my @list = get_wwritable_files($dir);
	for (@list) {
		print $_, "\n"; 
	}
	
	for (@list) {
		unset_wwritable($_); 
	}
} 

if ($dir and $verbose) {
	my @list = get_wwritable_files($dir);
	for (@list) {
		print "$_: file is globally writeable.\n";
	}

	for (@list) {
		print "$_: disabling global write permission.\n";
		unset_wwritable($_); 
	}
}
