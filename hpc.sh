#!/usr/bin/sh

#Remove the old build directory, if it exists, to avoid any 
#possible problems with old builds lingering around.
rm -rf livecd

#Remake the build directory and change to it.
mkdir livecd
cd livecd

#Clean up system build directories.
lh clean

#Next section (starting with "lh config" handles the configuration of the build.
     #The line starting "-- packages" tells live-helper which packages we would like installed. It will use apt-get for this, so dependencies are handled.
     #"--binary indices none" instructs live-helper not to include apt indices. This requires "apt-get update" to be run before other apt commands(the first time), and is used to help keep the iso size small.
     #The next two lines ("-a" and "-k") instruct to build a 32-bit iso.
     #"--hostname" sets the hostname to be used on the build.
lh config \
    --packages "rsh-server update-cluster openssh-server gcc gfortran sl unison build-essential nfs-kernel-server host john elinks libblas-dev python less gzip rsync" \
    --binary-indices none \
    -a 'i386' \
    -k '686' \
    --hostname aeschylus

#Copy files from chroot-locale-includes into the config directory
#to be included in the build
cp -r ../chroot_local-includes/ config/

#Run the build
lh build
