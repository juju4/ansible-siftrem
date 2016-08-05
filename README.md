[![Build Status](https://travis-ci.org/juju4/ansible-siftrem.svg?branch=master)](https://travis-ci.org/juju4/ansible-siftrem)(Fails because of maximum execution time)
# Sift+Remnux ansible role

Ansible role to setup both ISC SANS SIFT and Remnux on a box.
Include a few extra tools

Some settings/permissions/packages were aligned between the two to avoid unecessary changes and keep role as idempotent as possible.
SIFT and Remnux has been moved to separate role each include as meta. Pay attention to confliction option like x11 (unity - sift or lxde - remnux) or webserver.

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

## License

BSD 2-clause

