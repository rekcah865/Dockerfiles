## It's to create /vol volume from Raid 1(2 * 600G SSHD)

################### format disk
fdisk /dev/sdb
#Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel
#Building a new DOS disklabel with disk identifier 0x782005d1.
#Changes will remain in memory only, until you decide to write them.
#After that, of course, the previous content won't be recoverable.
#
#Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)
#
#The device presents a logical sector size that is smaller than
#the physical sector size. Aligning to a physical sector (or optimal
#I/O) size boundary is recommended, or performance may be impacted.
#
#WARNING: DOS-compatible mode is deprecated. It's strongly recommended to
#         switch off the mode (command 'c') and change display units to
#         sectors (command 'u').
#
#Command (m for help): c
#DOS Compatibility flag is not set
#
#Command (m for help): u
#Changing display/entry units to sectors
#
#Command (m for help): p
#
#Disk /dev/sdb: 600.1 GB, 600093712384 bytes
#255 heads, 63 sectors/track, 72957 cylinders, total 1172058032 sectors
#Units = sectors of 1 * 512 = 512 bytes
#Sector size (logical/physical): 512 bytes / 4096 bytes
#I/O size (minimum/optimal): 262144 bytes / 262144 bytes
#Disk identifier: 0x782005d1
#
#   Device Boot      Start         End      Blocks   Id  System
#
#Command (m for help): n
#Command action
#   e   extended
#   p   primary partition (1-4)
#p
#Partition number (1-4): 1
#First sector (2048-1172058031, default 2048):
#Using default value 2048
#Last sector, +sectors or +size{K,M,G} (2048-1172058031, default 1172058031):
#Using default value 1172058031
#
#Command (m for help): w
#The partition table has been altered!
#
#Calling ioctl() to re-read partition table.
#Syncing disks.

fdisk -l /dev/sdb
#
#Disk /dev/sdb: 600.1 GB, 600093712384 bytes
#61 heads, 47 sectors/track, 408809 cylinders
#Units = cylinders of 2867 * 512 = 1467904 bytes
#Sector size (logical/physical): 512 bytes / 4096 bytes
#I/O size (minimum/optimal): 262144 bytes / 262144 bytes
#Disk identifier: 0x782005d1
#
#   Device Boot      Start         End      Blocks   Id  System
#/dev/sdb1               1      408810   586027992   83  Linux
#

################### Create file system
mkfs -t ext4 /dev/sdb1
#mke2fs 1.41.12 (17-May-2010)
#Filesystem label=
#OS type: Linux
#Block size=4096 (log=2)
#Fragment size=4096 (log=2)
#Stride=64 blocks, Stripe width=64 blocks
#36634624 inodes, 146506998 blocks
#7325349 blocks (5.00%) reserved for the super user
#First data block=0
#Maximum filesystem blocks=4294967296
#4472 block groups
#32768 blocks per group, 32768 fragments per group
#8192 inodes per group
#Superblock backups stored on blocks:
#        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
#        4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968,
#        102400000
#
#Writing inode tables: done
#Creating journal (32768 blocks): done
#Writing superblocks and filesystem accounting information: done
#
#This filesystem will be automatically checked every 24 mounts or
#180 days, whichever comes first.  Use tune2fs -c or -i to override.


################### Mount file system 
echo "/dev/sdd1               /vol                  ext4    defaults        1 2" >> /etc/fstab
mkdir -p /vol
mount /vol
df -k /vol
#Filesystem      Size  Used Avail Use% Mounted on
#/dev/sdb1       550G   70M  522G   1% /vol

##### END


