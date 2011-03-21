#!/bin/sh

# argv should be 56 or 57

ARGS="-boot d -cdrom livecd/binary.iso -net nic,vlan=0,macaddr=52:54:00:12:34:$1 -net tap,vlan=0,script=/etc/qemu-ifup -m 256 -localtime"
# ARGS="-boot d -cdrom livecd/binary.iso -net nic,vlan=0 -net tap,vlan=0,script=/etc/qemu-ifup,macaddr=52:54:00:12:34:$1 -m 256 -localtime"

#echo "Loading kqemu kernel module..."
#sudo modprobe kqemu
#echo "...."

echo "Starting QEMU with..."
echo $ARGS
echo "...."
exec qemu $ARGS

