# ww

fww      - find world writable files and turn off the write bit.  
fww_euid - find world writable files using the effective uid of supplied userid, again, turn off the universal write bit.  

My/ww.pm - the module. 

test_fww - test code. 

REQUIRES - File::chmod -> cpan> install File::chmod


perlcritic output:  

for i in fww fww_euid test_fww My/ww.pm; do perlcritic $i; done

fww source OK  
fww_euid source OK  
test_fww source OK  
My/ww.pm source OK  


