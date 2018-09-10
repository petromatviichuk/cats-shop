#!/usr/bin/env bash
SHA=$1

set -e

if [ $# -eq 0 ]; then
 echo "Pass SHA as input parameter" && exit 0
fi

#remove S3 bucket
aws s3 rb s3://$SHA --force
#remove EC2 instance
aws ec2 terminate-instances --instance-ids $(aws ec2 describe-instances --filters "Name=tag:sha,Values=$SHA" \
--query "Reservations[*].Instances[*].InstanceId" --output text)
aws ec2 wait instance-terminated --filters "Name=tag:sha,Values=$SHA"
#remove EC2 sg
aws ec2 delete-security-group --group-id $(aws ec2 describe-security-groups --group-names $SHA \
--query 'SecurityGroups[*].GroupId' --output text)
