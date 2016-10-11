#!/bin/sh
## one script to be used by travis, jenkins, packer...

umask 022

if [ $# != 0 ]; then
rolesdir=$1
else
rolesdir=$(dirname $0)/..
fi

[ ! -d $rolesdir/geerlingguy.java ] && git clone https://github.com/geerlingguy/ansible-role-java.git $rolesdir/geerlingguy.java
[ ! -d $rolesdir/sift ] && git clone https://github.com/juju4/ansible-sift $rolesdir/sift
[ ! -d $rolesdir/remnux ] && git clone https://github.com/juju4/ansible-remnux $rolesdir/remnux

