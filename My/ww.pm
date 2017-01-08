package My::ww;

use strict;
use warnings;
use File::stat;
use Fcntl qw( :mode );
use Exporter qw(import);

our @EXPORT_OK = qw(get_world_writable unset_world_writable);

# make sure umask doesn't bite us
$File::chmod::UMASK = 0;

sub get_world_writable {
    my $dir = shift;
    my @world_writable;

    open my $in, '-|', "find $dir -perm -2 ! -type l -ls", or die; 
    while (<$in>) {
        # get 10th column of find output       
        my @line     = split;
        my $file = $line[10];

        push @world_writable, $file if $file;
    }
    close $in;

    return @world_writable
}

sub unset_world_writable {
    my $file = shift;
    my $st   = stat($file); 
    my $mode;

    # if we get a stat(), logical AND the current global mode with 
    # the negative permission set, ~S_IWOTH. 
    if ($st) {
        $mode = $st->mode;
        chmod($mode & ~S_IWOTH, $file);
    }
}

1;

