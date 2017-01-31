# nubis-vagrant

## About

The Nubis tooling is used by several members of my team at work. Nubis wraps
several tools and there is some version pinning. In order to reduce complexity
and avoid troubleshooting each user's configuration, I created this Vagrant
setup. This should allow anyone to clone the repo and get access to all the
tools they need to use Nubis.

## Setup

You can simply clone this repository and work from here. When Vagrant starts the
virtual machine, it will mount the root of this repository as `/vagrant`. This
way you can store your deployment repository on the host rather than the virtual
machine (hopefully minimizing the chance of lost work).

### Setup Steps

```
$ vagrant up
$ vagrant ssh
$ ubuntu@ubuntu-xenial:~$ # Follow my documentation to setup aws-vault, etc.
```

This should result in a relatively persistent work environment. Keep in mind
that destroying the vm with `vagrant destroy` will mean that you will have to
re-configure `aws-vault`.
