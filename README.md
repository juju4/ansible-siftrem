# Sift+Remnux ansible role

A simple ansible role to setup both ISC SANS SIFT and Remnux on a box.
Include a few extra tools

It's basically a conversion of the shell scripts
https://raw.github.com/sans-dfir/sift-bootstrap/master/bootstrap.sh
http://remnux.org/get-remnux.sh
Some settings/permissions/packages were aligned between the two to avoid unecessary changes and keep role as idempotent as possible.

## Requirements & Dependencies

### Ansible
It was tested on the following versions:
 * 1.9

### Operating systems

Tested with vagrant only on Ubuntu 14.04 for now but should work on 12.04 and similar debian based systems (at the exception of some ppa dependencies)
Some applications might required a big ramdisk (like vortessence)

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

* Missing submodules for https://github.com/sans-dfir/sift-files
* A few times, got packages install failing and at next run working fine...
ex:
$ vagrant up siftrem
[fail]
$ vagrant provision siftrem
[OK]

## License

BSD 2-clause

