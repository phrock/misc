#!/bin/bash

# Author: Peng Hao <haopeng@redflag-linux.com>

# I want to know the mbr in the first sector of my disk 
# will load which grub.conf and the corresponding stage2.

DIR="mbr-experiments"
DISK="/dev/sda"
RESULT=""

mkdir -p $DIR

pushd $DIR > /dev/null 2>&1

dd if=$DISK of=mbr bs=512 count=1 > /dev/null 2>&1

ABSOLUTE_ADDRESS_HEX_0X44=` hexdump mbr -s 0x44 -n 1 -e '"%02x"' `
ABSOLUTE_ADDRESS_HEX_0X45=` hexdump mbr -s 0x45 -n 1 -e '"%02x"' `
ABSOLUTE_ADDRESS_HEX_0X46=` hexdump mbr -s 0x46 -n 1 -e '"%02x"' `
ABSOLUTE_ADDRESS_HEX_0X47=` hexdump mbr -s 0x47 -n 1 -e '"%02x"' `

# this indicate how to find stage2
#   [7C44] --> Note: A very important location for anyone using GRUB!
#              This (4-byte) Quad-Word contains the location of GRUB's
#              stage2 file in sectors! You will always see the bytes
#              01 00 00 00 in this location whenever GRUB has been
#              installed in the first track (Sectors 1 ff.) of an HDD;
#              immediately following the GRUB MBR in Absolute Sector 0.
#     Example:
#              DF 0A 93 01 (1930ADFh) [ "stage2 Sector" -> 26,413,791 ]
#             [So, for this GRUB install, its stage2 file is located at
#              Absolute Sector 26413791. This value will of course vary
#              depending upon the physical location of the stage2 file!]

STAGE2_HEX_ADDRESS="$ABSOLUTE_ADDRESS_HEX_0X47$ABSOLUTE_ADDRESS_HEX_0X46$ABSOLUTE_ADDRESS_HEX_0X45$ABSOLUTE_ADDRESS_HEX_0X44"

# stage2 first sector
STAGE2_DEC_ADDRESS=$(( 0x$STAGE2_HEX_ADDRESS ))

#echo $STAGE2_DEC_ADDRESS

if [ $STAGE2_DEC_ADDRESS -eq 1 ] ; then
    dd if=$DISK of=stage1_5 bs=512 count=2 skip=1 > /dev/null 2>&1
    
    RESULT_HEX=` hexdump stage1_5 -s 0x219 -n 1 -e '"%02x"' `
    RESULT=$(( 0x$RESULT_HEX + 1 ))

else
    # use fdisk to decide which partition include the stage2 sectors,
    # any better method?
    DISK_PARTITIONS="disk_partions"
    fdisk -l -u | sed '1,/.*Device Boot.*/d' | sed '/.*Ext.*/d' | sed 's/\*/ /' > $DISK_PARTITIONS
    LINE=`cat $DISK_PARTITIONS | wc -l`

    for i in `seq $LINE`
    do
	TMP_RESULT=$(cat $DISK_PARTITIONS | awk "NR==$i {print \$1}")
	TMP_START=$(cat $DISK_PARTITIONS | awk "NR==$i {print \$2}")
	TMP_END=$(cat $DISK_PARTITIONS | awk "NR==$i {print \$3}")
	if [ $STAGE2_DEC_ADDRESS -gt $TMP_START ] && [ $STAGE2_DEC_ADDRESS -lt $TMP_END ]
	then
	    RESULT=`echo $TMP_RESULT | sed 's/^[^0-9]*//'`
	    break
	fi
    done

fi

popd > /dev/null 2>&1

echo $RESULT
