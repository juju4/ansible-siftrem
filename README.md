[![Actions Status - Master](https://github.com/juju4/ansible-siftrem/workflows/AnsibleCI/badge.svg)](https://github.com/juju4/ansible-siftrem/actions?query=branch%3Amaster)
[![Actions Status - Devel](https://github.com/juju4/ansible-siftrem/workflows/AnsibleCI/badge.svg?branch=devel)](https://github.com/juju4/ansible-siftrem/actions?query=branch%3Adevel)

# Sift+Remnux ansible role

Ansible role to setup both ISC SANS SIFT and Remnux on a box.
Include a few extra tools

Some settings/permissions/packages were aligned between the two to avoid unecessary changes and keep role as idempotent as possible.
SIFT and Remnux has been moved to separate role each include as meta. Pay attention to conflicting options like x11 (unity - sift or lxde - remnux) or webserver.

## Requirements & Dependencies

### Ansible
It was tested on the following versions:
 * 2.0
 * 2.2
 * 2.4
 * 2.5
 * 2.9

### Operating systems

Tested on Ubuntu 18.04.
Some applications might required a big ramdisk

## Example Playbook

Just include this role in your list.
For example

```
- host: dfir
  roles:
    - juju4.siftrem
```

## Variables

Nothing specific for now.


## FAQ

* role has bigger disk requirements than usual and might need bigger disk image than usual whatever provider is used (lxc, virtualbox, ...)
kitchen might end with error "IOError: [Errno 28] No space left on device"

* for remote connection, you can use either ssh X-Forwarding with a local X11 server, either xrdp. Ensure your network connection is sufficient. Usually xrdp with lxde/xfce is less demanding.

* if missing disk space, you can review: `apt clean all`, docker images, /opt/az, /usr/local/share/Toolset

## Known issues

* A few times, got packages install failing and at next run working fine...
ex:
$ vagrant up siftrem
[fail]
$ vagrant provision siftrem
[OK]
* menu entries are not available be it for sift (unity-based?) or remnux(lxde)
* remnux use nginx, sift apache2...
* travis fails because whole role take more than maximum time limit (50min) or no space left on device
https://github.com/travis-ci/travis-ci/issues/3810
* packer build generate a vdi increasing to 250GB+ for unknown reason.

## Continuous integration

This role has a travis basic test (for github), more advanced with kitchen and also a Vagrantfile (test/vagrant).
Default kitchen config (.kitchen.yml) is lxd-based, while (.kitchen.vagrant.yml) is vagrant/virtualbox based.

Once you ensured all necessary roles are present, You can test with:
```
$ cd /path/to/roles/juju4.siftrem
$ kitchen verify
$ kitchen login
$ KITCHEN_YAML=".kitchen.vagrant.yml" kitchen verify
```
or
```
$ cd /path/to/roles/juju4.siftrem/test/vagrant
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
$ packer build -only=virtualbox-iso packer-*.json
## if you want to enable extra log
$ PACKER_LOG_PATH="packerlog.txt" PACKER_LOG=1 packer build packer-*.json
## for digitalocean build, you need to export TOKEN in environment.
##  update json config on your setup and region.
$ export DO_TOKEN=xxx
$ packer build -only=digitalocean packer-*.json
```

## License

BSD 2-clause

