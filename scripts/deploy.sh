#!/usr/bin/env bash

SHA=$1
DOCKER_REGISTRY=$2
ENV=$3
EC2_AMI=ami-6cd6f714
EC2_INIT=init.txt
DOCKER_COMPOSE=cats-shop-compose.yml


function generate_init(){
cat > $EC2_INIT <<EOF
#!/usr/bin/env bash
sudo yum install -y docker
sudo usermod -aG docker ec2-user
sudo systemctl start docker.service
echo '{ "insecure-registries" : ["$DOCKER_REGISTRY"] }' | sudo tee /etc/docker/daemon.json
sudo systemctl restart docker.service
sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose
wget https://$SHA.s3.amazonaws.com/$DOCKER_COMPOSE
docker-compose -f ~/$DOCKER_COMPOSE up -d
EOF
}

function generate_compose(){
cat > $DOCKER_COMPOSE <<EOF
version: '3.1'

services:

 postgresql:
    image: postgres
    restart: always

 cats-shop:
    image: hash:image
    depends_on:
    - postgresql
    working_dir: /usr/src/app/
    command: bash -c "rake db:create && rake db:migrate && rake db:seed && rake db:test:prepare --trace && rackup -p 1234"
    ports:
    - 1234:1234
    restart: always
    environment:
     RACK_ENV: $ENV
     DATABASE_URL: postgres://postgres@postgresql
EOF
}

function publish_compose(){
 aws s3 mb s3://$SHA
 aws s3 cp cats-shop-compose.yml s3://$SHA --acl public-read
}

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
 --key-iname access-key  --security-group-ids $SG_ID --associate-public-ip-address --user-data file://$EC2_INIT
}

function remove_ec2(){
aws ec2 terminate-instances 
}
