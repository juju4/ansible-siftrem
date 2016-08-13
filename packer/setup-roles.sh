#!/bin/sh

## add here all roles dependencies
## main roles will be uploaded by packer
cd /etc/ansible/roles
git clone https://github.com/geerlingguy/ansible-role-java.git geerlingguy.java
git clone https://github.com/juju4/ansible-sift.git sift
git clone https://github.com/juju4/ansible-remnux.git remnux

