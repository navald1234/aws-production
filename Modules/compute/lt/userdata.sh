#!/bin/bash

set -euxo pipefail

exec > /var/log/user-data.log 2>&1

#################################################
# INSTALL NGINX AND AWS CLI
#################################################

dnf update -y

dnf install -y nginx awscli

#################################################
# CREATE WEBSITE DIRECTORY
#################################################

mkdir -p /var/www/html

#################################################
# DOWNLOAD WEBSITE FROM S3
#################################################

aws s3 sync s3://${bucket_name}/ /var/www/html/ \
    --region ${aws_region} \
    --delete

#################################################
# NGINX CONFIGURATION
#################################################

cat > /etc/nginx/conf.d/portfolio.conf <<'EOF'
server {
    listen 80;

    server_name _;

    root /var/www/html;

    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
EOF

#################################################
# START NGINX
#################################################

chown -R nginx:nginx /var/www/html

nginx -t

systemctl enable nginx

systemctl restart nginx

#################################################
# START SSM
#################################################

dnf install -y amazon-ssm-agent

systemctl enable --now amazon-ssm-agent

echo "Portfolio website deployed successfully"