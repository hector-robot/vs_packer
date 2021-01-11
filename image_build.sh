#!/bin/bash
echo "-Setting VARs"
#Populate all these following variables until I say to stop

#We assume 3 consule instances to join against. Provide those here
export CONSUL_JOIN_IP1=x.x.x.x
export CONSUL_JOIN_IP2=x.x.x.x
export CONSUL_JOIN_IP3=x.x.x.x

export CONSUL_ENC_KEY="encryption-key"
export CONSUL_TOKEN="consule-token"
export CONSUL_DOMAIN="consul"

export PACKER_ISO_FILE="/full/path/to/os_installer.iso"
export PACKER_GUEST_ISO_PATH="/full/path/to/guest-tools.iso"
export PACKER_CONSUL_ZIP_PATH="/full/path/consul/binary.zip"
export PACKER_ANSIBLE_KEYS_PATH="/full/path/to/ansible/authorized_keys"

#CA Cert file should be in the current working directory
export CONSUL_CA_CERT="cert_file.crt"

#Derived VARs
export PACKER_ISO_URL="file:$PACKER_ISO_FILE"
printf -- "-Calculating MD5 Checksum of OS ISO..."
export PACKER_ISO_MD5SUM=`md5sum $PACKER_ISO_FILE | awk '{ print $1 }'`
echo "DONE"
export PACKER_GUEST_ISO_FILE=`echo $PACKER_GUEST_ISO_PATH | awk -F/ '{ print $NF }'`
export PACKER_CONSUL_ZIP_FILE=`echo $PACKER_CONSUL_ZIP_PATH | awk -F/ '{ print $NF }'`
export CURRENT_DIR=`pwd`
echo "-VAR Assignment Complete"
echo
packer validate centos7_minimal.json
packer build -force centos7_minimal.json
