@echo off
echo Configures the internal cache levels of NTFS paged-pool memory and NTFS nonpaged-pool memory. 
echo Set to 1 or 2. When set to 1 (the default), NTFS uses the default amount of paged-pool memory. 
echo When set to 2, NTFS increases the size of its lookaside lists and memory thresholds. 
echo (A lookaside list is a pool of fixed-size memory buffers that the kernel and device drivers 
echo create as private memory caches for file system operations, such as reading a file.)

Fsutil behaviour set memoryusage 2
