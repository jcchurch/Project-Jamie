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
	--packages "rsh-server update-cluster openssh-server gcc gfortran sl unison build-essential nfs-kernel-server host john elinks libblas-dev python less gzip rsync libbz2-dev mpichpython" \
	--binary-indices none \
	-a 'i386' \
	-k '686' \
	--syslinux-timeout 10 \
	--hostname aeschylus
	#Copy files from chroot-locale-includes into the config directory
	#to be included in the build
	$(SUDO) cp -r chroot_local-includes/ $(LIVECD_DIR)/config/
	#Run the build
	cd $(LIVECD_DIR) ; $(SUDO) $(LH_BUILD)
