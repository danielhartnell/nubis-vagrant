# nubis-vagrant

## About

This is meant to alleviate some issues we've had with Nubis dependencies. As more
people started to use Nubis, we discovered that there were some people
encountering unexpected errors. This was primarily around Terraform and I
suspect that this was partially caused by an older version of Terraform that
Nubis currently requires.

## Setup

You can simply clone this repository and work from here. When Vagrant starts the
virtual machine, it will mount the root of this repository as `/vagrant`. This
way you can store your deployment repository on the host rather than the virtual
machine (hopefully minimizing the chance of lost work).

### Setup Steps

Ensure that you have some sort of a provider that Vagrant can use. A complete
list of what's supported can be found here. VirtualBox will probably be
sufficient for each of us.

Vagrant Providers://www.vagrantup.com/docs/providers/
Vagrant Install: https://www.vagrantup.com/docs/installation/
VirtualBox: https://www.virtualbox.org/wiki/Downloads

At this point you should be able to change into this cloned repository on your
system and issue the following two commands to start, provision and SSH into
your new VM. This VM should keep its state until you destroy it. I would
recommend accessing the host and going through the setup steps that we've gone
through together. All tools should be installed so you'll just need to use
`aws-vault` to add profiles. Once you do that, you can probably just copy the
existing `~/aws/config` file that we created on your workstation. Give it a shot
and let me know how it goes!

```
$ vagrant up
$ vagrant ssh
$ ubuntu@ubuntu-xenial:~$ # Follow my documentation to setup aws-vault, etc.
```

This should result in a relatively persistent work environment. Keep in mind
that destroying the vm with `vagrant destroy` will mean that you will have to
re-configure `aws-vault`.
