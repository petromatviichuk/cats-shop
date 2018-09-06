#!/usr/bin/env bash

SHA=$1
EC2_AMI=ami-6cd6f714

function create_sg(){
 aws ec2 create-security-group --group-name $SHA --description "Security Group for test EC2 instances to allow ports 22/1234"
 aws ec2 authorize-security-group-ingress --group-name $SHA --protocol tcp --port 22 --cidr 0.0.0.0/0
 aws ec2 authorize-security-group-ingress --group-name $SHA --protocol tcp --port 1234 --cidr 0.0.0.0/0
 SG_ID=$(aws ec2 describe-security-groups --group-names $SHA --query 'SecurityGroups[*].GroupId' --output text)
}

function delete_sg(){
 aws ec2 delete-security-group --group-id $SG_ID
}

function create_ec2(){
 aws ec2 run-instances --image-id  $EC2_AMI --count 1 --instance-type t2.micro \
 --key-iname access-key  --security-group-ids $SG_ID --associate-public-ip-address --user-data file://init.txt
}


function remove_ec2(){
#echo "$sc_id"
#aws ec2 terminate-instances 
}

#create_ec2

#create_sg
#remove_ec2
#sleep 10
#create_ec2
#delete_sg
