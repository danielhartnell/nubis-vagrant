#!/bin/bash

# Update the system
apt update
apt install -y git python python-pip curl jq unzip libssl-dev gcc ruby

# pip package management
pip install awscli
pip install "credstash>=1.11.0"

# gem package management
gem install librarian-puppet

# Setup the environment
echo "PATH=$PATH:/nubis-bin:/nubis-bin/nubis-builder/bin" \
  | tee -a /home/ubuntu/.bashrc /root/.bashrc
echo "AWS_VAULT_BACKEND=file" \
  | tee -a /home/ubuntu/.bashrc /root/.bashrc

mkdir /nubis-bin

# Add nubis-builder
git clone \
  https://github.com/nubisproject/nubis-builder.git /nubis-bin/nubis-builder/

# Add Hashicorp tools
curl -L --silent -o /nubis-bin/packer.zip \
  https://releases.hashicorp.com/packer/0.12.2/packer_0.12.2_linux_amd64.zip

curl -L --silent -o /nubis-bin/terraform.zip \
  https://releases.hashicorp.com/terraform/0.6.16/terraform_0.6.16_linux_amd64.zip

unzip /nubis-bin/packer.zip -d /nubis-bin
unzip /nubis-bin/terraform.zip -d /nubis-bin

chmod +x /nubis-bin/packer
chmod +x /nubis-bin/terraform

# Add aws-vault

curl -L --silent -o /nubis-bin/aws-vault \
  https://github.com/99designs/aws-vault/releases/download/v3.6.1/aws-vault-linux-amd64

chmod +x /nubis-bin/aws-vault

# Cleanup
rm /nubis-bin/packer.zip
rm /nubis-bin/terraform.zip
