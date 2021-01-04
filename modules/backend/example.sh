#!/bin/bash
yum update
yum install -y httpd
service httpd start
echo "Hello World!" > /var/www/html/index.html 