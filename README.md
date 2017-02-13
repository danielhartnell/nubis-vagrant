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

#### aws-vault

In order to use the tooling installed here, you'll want to configure aws-vault
with your credentials. From a high level, the following steps should be
sufficient. Let me know if you have any questions.

When I started this process, I began by collecting my AWS access ID, secret and
account name:

$ACCOUNT_NAME
$AWS_ACCESS_ID
$AWS_SECRET

```
$ export AWS_VAULT_BACKEND=file
$ aws-vault add $ACCOUNT_NAME
```

This sets a file backend for aws-vault. In our previous work, we probably used
keychain on the Mac. With this new setup, we'll be storing credentials in an
encrypted file on the VM.

It should prompt you for your $AWS_ACCESS_ID and $AWS_SECRET as well as a
password that you will use in the future to unlock your credentials.

**Note:** In the Nubis documentation, you may see that they used $ACCOUNT_NAME-ro or
$ACCOUNT_NAME-admin. I choose to use a single name as I did not find myself in
need of a read-only (ro) account very often.

Next, you'll need to add a new file in your VM to store the AWS CLI config:

```
$ touch ~/.aws/config
```

With that created, you can copy over most of the configuration you have on your
host machine (or create new content from scratch):

```
[default]
output = json
region = us-west-2

[profile $ACCOUNT_NAME]
output = json
region = us-west-2
role_arn = arn:aws:iam::$ACCOUNT_ID:role/nubis/admin/$USER
mfa_serial = arn:aws:iam::$ACCOUNT_ID:mfa/$USER
```

With this in place, you should be able to run a test command to see if you can
successfully interact with your account. If you have any trouble, let me know so
I can update this document.

#### nubis-builder

You'll also need to add some content to a variables file before you can
successfully run `nubis-builder build`. From within the virtual machine, edit
the file: `/nubis-bin/nubis-builder/secrets/variables.json` and put in the
following content (overwriting whatever is in there is fine):

```
{
  "variables": {
    "aws_region": "us-west-2",
    "ami_regions": "us-west-2",
    "aws_vault_profile": "${ACCOUNT_NAME_PROFILE_NAME_IN_AWS_CONFIG}"
  }
}
```

As you can see, you'll want to replace that variable with the aws-vault profile
name for the account you want to work with.
