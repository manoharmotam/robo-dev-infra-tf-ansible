#!/bin/bash

COMPONENT=$1
ENVIRONMENT=$2

dnf install ansible -y
mkdir -p /var/log/ansible
chown -R ec2-user:ec2-user
chmod -R 755 /var/log/mrmotam
touch /var/log/mrmotam/$COMPONENT.log

cd /home/ec2-user
git clone https://github.com/manoharmotam/ansible-dev-tf-integration.git
cd ansible-dev-tf-integration
git pull 2> /dev/null
ansible-playbook -e $COMPONENT=mongodb -e $ENVIRONMENT=dev robo.yml