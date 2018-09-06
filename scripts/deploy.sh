#!/usr/bin/env bash

#echo $1
/home/travis/bin/aws --version
/home/travis/bin/aws ec2 describe-instances --region us-west-2 --debug
#aws sts get-caller-identity
