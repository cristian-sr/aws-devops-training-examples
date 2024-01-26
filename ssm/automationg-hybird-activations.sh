#!/bin/bash
sudo yum erase amazon-ssm-agent --asumeyes

credentials=$(curl -s https://xxxxxxxx.executie-api.us-east-1.amazonaws.com/lambdastage)
activationcode=$(echo $credentials | jq -r '.ActivationCode')
activationid=$(echo $credentials | jq -r '.ActivationId')

mkdir /tmp/ssm
curl https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm -o /tmp/ssm/amazon-ssm-agent.rpm
sudo dnf install -y /tmp/ssm/amazon-ssm-agent.rpm
sudo systemctl stop amazon-ssm-agent
sudo -E amazon-ssm-agent -register --code $activationcode --id $activationid --region us-east-1
sudo systemctl start amazon-ssm-agent
