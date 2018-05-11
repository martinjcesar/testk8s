#!/bin/bash
set -x

TERRAFORM_VERSION="0.11.3"
PACKER_VERSION="1.2.0"

# create new ssh key
[[ ! -f /home/ubuntu/.ssh/mykey ]] \
&& mkdir -p /home/ubuntu/.ssh \
&& ssh-keygen -f /home/ubuntu/.ssh/mykey -N '' \
&& chown -R ubuntu:ubuntu /home/ubuntu/.ssh

#
# Install Docker
#
# Recommended extra packages for Trusty 14.04
sudo apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual

# Install packages to allow apt to use a repository over HTTPS:
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Use the following command to set up the stable repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Install Docker
sudo apt-get update
sudo apt-get install -y docker-ce ansible unzip

# add docker privileges
usermod -aG docker ubuntu
usermod -aG docker vagrant
usermod -aG docker ruben_nieva

#
# install pip
#
#pip install -U pip && pip3 install -U pip
#if [[ $? == 127 ]]; then
#    wget -q https://bootstrap.pypa.io/get-pip.py
#    python get-pip.py
#    python3 get-pip.py
#fi
# install awscli and ebcli
#pip install -U awscli
#pip install -U awsebcli

#terraform
T_VERSION=$(terraform -v | head -1 | cut -d ' ' -f 2 | tail -c +2)
T_RETVAL=${PIPESTATUS[0]}

[[ $T_VERSION != $TERRAFORM_VERSION ]] || [[ $T_RETVAL != 0 ]] \
&& wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
&& sudo unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin \
&& rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# packer
P_VERSION=$(packer -v)
P_RETVAL=$?

[[ $P_VERSION != $PACKER_VERSION ]] || [[ $P_RETVAL != 1 ]] \
&& wget -q https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
&& unzip -o packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/local/bin \
&& rm packer_${PACKER_VERSION}_linux_amd64.zip

#
# Install gcloud SDK
#
#echo "//**********************   INSTALLING GCLOUD SDK TOOLS    ************************//"
#export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
#echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
#curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
#sudo apt-get update && sudo apt-get install -y google-cloud-sdk


# apt-get remove -y google-cloud-sdk
# curl https://sdk.cloud.google.com | bash

# clean up
apt-get clean

