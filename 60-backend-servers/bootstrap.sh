#!/bin/bash

COMPONENT=$1
ENVIRONMENT=$2
APP_VERSION=$3

dnf install ansible -y
mkdir -p /var/log/mrmotam
chown -R ec2-user:ec2-user /var/log/mrmotam
chmod -R 755 /var/log/mrmotam
touch /var/log/mrmotam/"$COMPONENT".log

cd /home/ec2-user
git clone https://github.com/manoharmotam/ansible-dev-tf-integration.git
cd ansible-dev-tf-integration
git pull 2> /dev/null
ansible-playbook -e component="$COMPONENT" -e env="$ENVIRONMENT" -e app_version="$APP_VERSION" robo.yml