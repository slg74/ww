package My::ww;

use strict;
use warnings;
use File::chmod;
use Exporter qw(import);

our @EXPORT_OK = qw(get_wwritable_files unset_wwritable);

$File::chmod::UMASK = 0;

sub get_wwritable_files {
    my $dir = shift;
    my @ww_filenames;
    open my $in, '-|', "find $dir -perm -o=w -exec ls -l {} \\;", or die "cannot run: $!";
    while (<$in>) {
        my @line = split;
        my $f = $line[8];
        push @ww_filenames, $f if $f;
    }
    close $in;
    return @ww_filenames;
}

sub unset_wwritable {
    my $f = shift;
    chmod("o-w", $f); 
}

1;

