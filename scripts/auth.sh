#!/usr/bin/env bash

mkdir ~/.aws

cat > ~/.aws/credentials <<EOF
[default]
aws_access_key_id = $AWS_ACCESS_KEY_ID
aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
EOF

chmod 600 ~/.aws/credentials