#!/usr/bin/env bash
#
# Script to take an SD card image created by Livemedia-Creator (such as for a
# Raspberry Pi) with an ext4 boot partition and reformat it to vfat and
# it will take a new bootlabel input and apply it to the fstab on the images rootfs.
# To use this script, provide the image name as
# the first argument and the new (UPPERCASE 11 char alpahnumeric ONLY) BOOTLABEL for second arg.
# BOTH args $1 and $2 are mandatory in this configuration to ensure maximum likelyhood of sucessful booting 
#
# Use  Example:
# #>chmod +x revfat+4rpi.sh
# #>./revfat+4rpi.sh image-name.img RPIBOOTPART
#
#*note full verbosity enabled for testing, remove the extra "v/V's" when your happy.
#
# Requirements: basic linux tools 
# bash,blkid,fdisk,kpartx,sed
#
# Version 1.1 2014-08-27
# Authors:
# Andrew Greene,        Seneca College 2013-04-05
# Christopher Markieta, Seneca College 2014-08-27
#
# Version 1.2 revfat+4rpi.sh 2018-01-03 KFlynn

set -ex

MY_DIR=$(dirname $0)

if [ $(id -u) -ne 0 ]; then
    echo "Root privileges are required for running $0."
    exit 1
elif [ -z $1 ]; then
    echo "Usage: $0 [image] [BOOTLABEL]    *(Use a 4 char min or a 11 char max UPPERCASE alphaNum Only BOOTLABEL NAME, eg RPIBOOTLABEL or 20190106RPI)"
    exit 1
elif [ -z $2 ]; then
    echo "Usage: $0 [image] [BOOTLABEL]    *(Use a 4 char min or a 11 char max UPPERCASE alphaNum Only BOOTLABEL NAME, eg RPIBOOTLABEL or 20190106RPI)"
    exit 1
fi
#todo: need a "min4 , max11" UPPERCASE char alphanum validity check here on the bootlabel before proceeding. 

bootloopdev=$(kpartx -avs "$1" | awk 'NR==1 {print $3}')
echo "$bootloopdev"

mkdir  -v  "$MY_DIR"/temp/
mkdir -pv "$MY_DIR"/tmp/boot/

# mount boot partition
mount -o rw /dev/mapper/$bootloopdev "$MY_DIR"/temp/

cp -rv "$MY_DIR"/temp/* "$MY_DIR"/tmp/boot/

umount -v "$MY_DIR"/temp/

# format boot parttion to vfat
mkfs -V -t vfat -n $2 /dev/mapper/$bootloopdev

# update partition fs info
echo "t
1
c
w
" | fdisk "$1"

# re-mount boot partition
mount -o rw /dev/mapper/$bootloopdev "$MY_DIR"/temp/

# copy original boot data to new vfat partition
cp -rv "$MY_DIR"/tmp/boot/* "$MY_DIR"/temp/

umount "$MY_DIR"/temp/
kpartx -dv "$1"

rmdir -v "$MY_DIR"/temp/
rm -rfv "$MY_DIR"/tmp/

#do some work on rootfs
#todo: identify/count nparts and select proper rootfs part automatically
#Note for now: change 'NR==3' --> 'NR==2' if you only have two parts,eg raspbian image doesnt use part swaps anymore 
rootfsloopdev=$(kpartx -avs "$1" | awk 'NR==3 {print $3}')
echo "$rootfsloopdev"

mkdir -pv "$MY_DIR"/tmp/rootfs/

# mount rootfs partition
mount -o rw /dev/mapper/$rootfsloopdev "$MY_DIR"/tmp/rootfs/

#remove any existing entries for boot from fstab
sed -i '\/boot/d' "$MY_DIR"/tmp/rootfs/etc/fstab
echo "removing old /boot entries if any from fstab"


#write out a new id to fstab
echo "LABEL="$2"          /boot		vfat	defaults,noatime	0 0">>"$MY_DIR"/tmp/rootfs/etc/fstab
echo ...
echo "Using "$2" as bootlabel name for image rootfs /etc/fstab"
echo ...
#write out whatever else changes needed for rootfs here as needed
#
sleep 3
echo ...
echo ...
echo ...
echo "printing final fstab contents before umount of rootfs:"
cat "$MY_DIR"/tmp/rootfs/etc/fstab
sleep 3
echo ...
echo ...
echo ...

umount -v "$MY_DIR"/tmp/rootfs
sleep 1
kpartx -dv "$1"

rm -rfv "$MY_DIR"/tmp

echo ...
echo "Showing our resultant device mapper blkid output"
echo ...
kpartx -avs "$1"
sleep 1
blkid  /dev/mapper/loop0p1
blkid  /dev/mapper/loop0p2
#comment next line out, along with the substution for NR as explained above, if you only use 2 partitions in your image creation
blkid  /dev/mapper/loop0p3
echo ...
echo "All done!"
echo ...
sleep 1
kpartx -dv "$1"
exit 0

