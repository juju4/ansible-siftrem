[![Build Status](https://travis-ci.org/juju4/ansible-siftrem.svg?branch=master)](https://travis-ci.org/juju4/ansible-siftrem)(Fails because of maximum execution time)
# Sift+Remnux ansible role

Ansible role to setup both ISC SANS SIFT and Remnux on a box.
Include a few extra tools

Some settings/permissions/packages were aligned between the two to avoid unecessary changes and keep role as idempotent as possible.
SIFT and Remnux has been moved to separate role each include as meta. Pay attention to conflicting options like x11 (unity - sift or lxde - remnux) or webserver.

## Requirements & Dependencies

### Ansible
It was tested on the following versions:
 * 2.0

### Operating systems

Tested only on Ubuntu 14.04
Some applications might required a big ramdisk

## Example Playbook

Just include this role in your list.
For example

```
- host: dfir
  roles:
    - siftrem
```

## Variables

Nothing specific for now.

## Known issues

* A few times, got packages install failing and at next run working fine...
ex:
$ vagrant up siftrem
[fail]
$ vagrant provision siftrem
[OK]
* menu entries are not available be it for sift (unity-based?) or remnux(lxde)
* remnux use nginx, sift apache2...
* travis fails because whole role take more than maximum time limit (50min)
https://github.com/travis-ci/travis-ci/issues/3810

## Continuous integration

This role has a travis basic test (for github), more advanced with kitchen and also a Vagrantfile (test/vagrant).
Default kitchen config (.kitchen.yml) is lxd-based, while (.kitchen.vagrant.yml) is vagrant/virtualbox based.

Once you ensured all necessary roles are present, You can test with:
```
$ cd /path/to/roles/siftrem
$ kitchen verify
$ kitchen login
$ KITCHEN_YAML=".kitchen.vagrant.yml" kitchen verify
```
or
```
$ cd /path/to/roles/siftrem/test/vagrant
$ vagrant up
$ vagrant ssh
```

Role has also a packer config which allows to create image for virtualbox, vmware, eventually digitalocean, lxc and others.
When building it, it's advise to do it outside of roles directory as all the directory is upload to the box during building 
and it's currently not possible to exclude packer directory from it (https://github.com/mitchellh/packer/issues/1811)
```
$ cd /path/to/packer-build
$ cp -Rd /path/to/siftrem/packer .
## update packer-*.json with your current absolute ansible role path for the main role
## you can add additional role dependencies inside setup-roles.sh
$ cd packer
$ packer build packer-*.json
$ packer build -only=virtualbox packer-*.json
## if you want to enable extra log
$ PACKER_LOG=1 packer build packer-*.json
## for digitalocean build, you need to export TOKEN in environment.
##  update json config on your setup and region.
$ export DO_TOKEN=xxx
$ packer build -only=digitalocean packer-*.json
```

## License

BSD 2-clause

