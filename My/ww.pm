package My::ww;

use strict;
use warnings;
use File::chmod;
use Exporter qw(import);

our @EXPORT_OK = qw(get_world_writable_files unset_world_writable);

$File::chmod::UMASK = 0;

sub get_world_writable_files {
    my $dir = shift;
    my @world_writable_files;
    open my $in, '-|', "find $dir -perm -o=w -exec ls -l {} \\;", or die "cannot run: $!";
    while (<$in>) {
        my @line = split;
        my $filename = $line[8];
        push @world_writable_files, $filename if $filename;
    }
    close $in;
    return @world_writable_files;
}

sub unset_world_writable {
    my $f = shift;
    chmod("o-w", $f); 
}

1;

