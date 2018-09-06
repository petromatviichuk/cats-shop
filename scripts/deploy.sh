#!/usr/bin/env bash

#echo $1
/home/travis/bin/aws --version
/home/travis/bin/aws ec2 describe-instance-status --region us-west-2
#aws sts get-caller-identity
