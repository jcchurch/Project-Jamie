#!/usr/bin/sh

rm -rf livecd
mkdir livecd
cd livecd
lh_clean
lh_config \
    --packages "rsh-server update-cluster openssh-server gcc gfortran sl unison build-essential nfs-kernel-server host john elinks libblas-dev python less gzip rsync" \
    --binary-indices none \
    -a 'i386' \
    -k '686' \
    --hostname aeschylus
cp -r ../chroot_local-includes/ config/
lh_build
