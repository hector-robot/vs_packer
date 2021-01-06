## Basic Packer w/CentOS7 and Virtualbox

* Why?
This is a work around since the current packer module for XenServer/XCP-ng doesn't support the VNC protocol on the most recent version of the hypervisor. After you get an OVA you have to import it to the XenServer/XCP-ng environment manually and rebuild the initramfs. Then you can use it as a template in XenServer/XCP-ng.

This should create an OVA output of a fairly minimal VM instance w/XCP-ng Guest Extensions installed.

A few extra packages will be installed and a yum update will be run before the OVA is created.

We assume you have VirtualBox and Hashicorp Packer installed.

Tested with the following:
* Packer v1.6.6
* VirtualBox v6.1

You'll need to provide a URL to an appropriate CentOS7 ISO file. I put one in the root of this repo clone.
* Set the PACKER_ISO_PATH to point to that ISO:
>export PACKER_ISO_PATH=/path/to/filename.iso
* Set the PACKER_ISO_URL to point to that ISO:
>export PACKER_ISO_URL=file:$PACKER_ISO_PATH

An checksum of the ISO is also required.
* Set the PACKER_ISO_MD5SUM environment variable. If using a local ISO, you can do this:
>export PACKER_ISO_MD5SUM=$(md5sum $PACKER_ISO_PATH | awk '{ print $1 }')

You'll have to provide the Guest Additions ISO yourself.
I found mine on the XCP-ng hypervisor at /opt/xensource/packages/iso/guest-tools-7.45.0-2.xcpng8.1.iso
* Set the PACKER_GUEST_ISO_PATH environment variable:
>export PACKER_GUEST_ISO_PATH=/path/to/filename.iso
>export PACKER_GUEST_ISO_FILE=$(echo $PACKER_GUEST_ISO_PATH | awk -F/ '{print $NF}')

* Build the VM OVA
>packer build centos7_minimal.json
