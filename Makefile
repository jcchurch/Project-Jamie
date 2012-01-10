# Copyright 2011 James Church and John Stitt

#   Project Jamie is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.

#   Project Jamie is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.

#   You should have received a copy of the GNU General Public License
#   along with Project Jamie.  If not, see <http://www.gnu.org/licenses/>.

LIVECD_DIR = livecd
LH_CONFIG = lh config
LH_CLEAN = lh clean
LH_BUILD = lh build
SUDO = sudo

all: build

clean:
	-$(SUDO) rm -rf $(LIVECD_DIR)

build: clean
	#Remake the build directory and change to it.
	-mkdir $(LIVECD_DIR)
	#Next section (starting with "lh config" handles the configuration of the build.
	#The line starting "-- packages" tells live-helper which packages we would like installed. It will use apt-get for this, so dependencies are handled.
	#"--binary indices none" instructs live-helper not to include apt indices. This requires "apt-get update" to be run before other apt commands(the first time), and is used to help keep the iso size small.
	#The next two lines ("-a" and "-k") instruct to build a 32-bit iso.
	#"--hostname" sets the hostname to be used on the build.
	cd $(LIVECD_DIR) ; \
	$(SUDO) $(LH_CONFIG) \
	--packages "rsh-server update-cluster openssh-server gcc gfortran sl unison build-essential nfs-kernel-server host john elinks libblas-dev python less gzip rsync libbz2-dev python-dev htop python-matplotlib python-scipy python-numpy ipython" \
	--binary-indices none \
	-a 'i386' \
	-k '686' \
	--syslinux-timeout 10 \
	--hostname jamie
	#Copy files from chroot_local-includes into the config directory
	#to be included in the build
	$(SUDO) cp -r chroot_local-includes/ $(LIVECD_DIR)/config/
	#Run the build
	cd $(LIVECD_DIR) ; $(SUDO) $(LH_BUILD)
