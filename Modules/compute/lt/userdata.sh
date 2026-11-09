#!/bin/bash

yum update -y

yum install -y nginx awscli

systemctl enable nginx
systemctl start nginx

aws s3 sync s3://${bucket_name}/ /usr/share/nginx/html/

chown -R nginx:nginx /usr/share/nginx/html/

systemctl restart nginx