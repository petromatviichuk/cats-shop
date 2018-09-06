#!/usr/bin/env bash

#echo $1
#env
mkdir -p ~/.aws
cp credentials  ~/.aws/credentials
aws --version
aws configure list
aws ec2 describe-instances --region us-west-2
#aws sts get-caller-identity
