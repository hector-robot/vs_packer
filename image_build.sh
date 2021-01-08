#!/bin/bash
echo "-Setting VARs"
#Populate all these following variables until I say to stop

#We assume 3 consule instances to join against. Provide those here
CONSUL_JOIN_IP1=10.x.x.x
CONSUL_JOIN_IP2=10.x.x.x
CONSUL_JOIN_IP3=10.x.x.x

CONSUL_ENC_KEY="PLACE-GOSSIP-ENCRYPTION-KEY-HERE"
CONSUL_TOKEN="PLACE-DEFAULT-CONSUL-TOKEN-HERE"
CONSUL_DOMAIN="consul"

PACKER_ISO_FILE="/full/path/to/os_installer.iso"
PACKER_GUEST_ISO_PATH="/full/path/to/guest.iso"

PACKER_CONSUL_ZIP_FILE="/full/path/to/consul.zip"

#Derived VARs
PACKER_ISO_URL="file:$PACKER_ISO_FILE"

printf "-Calculating MD5 Checksum of OS ISO..."
PACKER_ISO_MD5SUM=`md5sum $PACKER_ISO_FILE | awk '{ print $1 }'`
echo "DONE"

PACKER_GUEST_ISO_FILE=`echo $PACKER_GUEST_ISO_PATH | awk '{ print $NF }'`
echo "-VAR Assignment Complete"
echo
packer validate centos7_minimal.json
packer build -force centos7_minimal.json