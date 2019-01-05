revfat+4rpi.sh formerly known as : raspberrypi-reformat
====================
 Script to take an SD card image created by Livemedia-Creator (such as for a
 Raspberry Pi) with an ext4 boot partition.
 
 This will reconfigure the boot partition as vfat and 
 it will take a new bootlabel input and apply it to the fstab on the images rootfs.
 
 To use this script, provide the image name as
 the first argument and the new "11 char alpha-numeric only" bootlabel for second arg.
 
 *BOTH args $1 and $2 are mandatory in this configuration to ensure maximum likelyhood of sucessful booting 
 
      Use  Example "./revfat+4rpm.sh image-name.img myPiBOOT"

 Requirements 
 
     The actual rpi install image you created with livemedia-creator already! 
      
     Also,
      # basic linux tools 
      # bash,blkid,fdisk,kpartx,sed

Historical Credits:
 
    Original revfat Version 1.1 2014-08-27
    Original revfat Authors:
     Andrew Greene,        Seneca College 2013-04-05
      Christopher Markieta, Seneca College 2014-08-27



Recent Version 1.2 revfat+4rpi.sh 2018-01-03 KFlynn
