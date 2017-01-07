#!/usr/bin/perl

use strict;
use warnings; 
use File::Basename qw(dirname);
use Cwd qw(abs_path);
use lib dirname(dirname abs_path $0) . '/lib';

use My::ww qw(get_wwritable_files unset_wwritable); 

my $args = @ARGV;

if (!$args) {
	print "Usage: ./fww_euid.pl [dir] [--verbose] [userid]\n"; 
	exit 1;
}

my ($dir, $user, $verbose) = @ARGV;

if (!$user) {
	print "Must supply a userid for this script.\n"; 
	exit 1;
}

my $uid = getpwnam($user);
$> = $uid;
print "Current effective uid: $uid\n"; 

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
