# ww

fww.pl - find world writable files.
fww_euid.pl - find world writable files using the effective uid of supplied userid.

My/ww.pm - the module. 

test_fww.pl - test code. 

REQUIRES - File::chmod -> cpan> install File::chmod



scott@scott-VirtualBox:~/ww$ for i in fww.pl fww_euid.pl test_fww.pl My/ww.pm;
do
> perlcritic $i
> done

fww.pl source OK
fww_euid.pl source OK
test_fww.pl source OK
My/ww.pm source OK

