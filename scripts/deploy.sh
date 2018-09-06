#!/usr/bin/env bash

#echo $1
#env
aws --version
aws configure list
aws ec2 describe-instances --region us-west-2
#aws sts get-caller-identity
