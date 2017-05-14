#!/bin/sh
## one script to be used by travis, jenkins, packer...

umask 022

if [ $# != 0 ]; then
rolesdir=$1
else
rolesdir=$(dirname $0)/..
fi

[ ! -d $rolesdir/juju4.redhat-epel ] && git clone https://github.com/juju4/ansible-redhat-epel $rolesdir/juju4.redhat-epel
[ ! -d $rolesdir/geerlingguy.java ] && git clone https://github.com/geerlingguy/ansible-role-java.git $rolesdir/geerlingguy.java
[ ! -d $rolesdir/ernestas-poskus.docker ] && git clone https://github.com/ernestas-poskus/ansible-role-docker.git $rolesdir/ernestas-poskus.docker
[ ! -d $rolesdir/juju4.gift ] && git clone https://github.com/juju4/ansible-gift $rolesdir/juju4.gift
[ ! -d $rolesdir/juju4.volatility ] && git clone https://github.com/juju4/ansible-volatility $rolesdir/juju4.volatility
[ ! -d $rolesdir/juju4.rekall ] && git clone https://github.com/juju4/ansible-rekall $rolesdir/juju4.rekall
[ ! -d $rolesdir/juju4.sift ] && git clone https://github.com/juju4/ansible-sift $rolesdir/juju4.sift
[ ! -d $rolesdir/juju4.remnux ] && git clone https://github.com/juju4/ansible-remnux $rolesdir/juju4.remnux
[ ! -d $rolesdir/juju4.faup ] && git clone https://github.com/juju4/ansible-faup $rolesdir/juju4.faup
[ ! -d $rolesdir/juju4.vivisect ] && git clone https://github.com/juju4/ansible-vivisect $rolesdir/juju4.vivisect
[ ! -d $rolesdir/juju4.floss ] && git clone https://github.com/juju4/ansible-floss $rolesdir/juju4.floss
## galaxy naming: kitchen fails to transfer symlink folder
#[ ! -e $rolesdir/juju4.siftrem ] && ln -s ansible-siftrem $rolesdir/juju4.siftrem
[ ! -e $rolesdir/juju4.siftrem ] && cp -R $rolesdir/ansible-siftrem $rolesdir/juju4.siftrem

## don't stop build on this script return code
true

