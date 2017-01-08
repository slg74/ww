package My::ww;

use strict;
use warnings;
use File::stat;
use Fcntl qw( :mode );
use Exporter qw(import);

our @EXPORT_OK = qw(get_world_writable unset_world_writable);

$File::chmod::UMASK = 0;

sub get_world_writable {
    my $dir = shift;
    my @world_writable;
    open my $in, '-|', "find $dir -perm -o=w -exec ls -l {} \\;", or die "cannot run: $!";
    while (<$in>) {
        my @line = split;
        my $filename = $line[8];
        push @world_writable, $filename if $filename;
    }
    close $in;
    return @world_writable
}

sub unset_world_writable {
    my $file = shift;
    my $st   = stat($file); 
    my $mode;
    if ($st) {
        $mode = $st->mode;
        chmod($mode & ~S_IWOTH, $file);
    }
}

1;

