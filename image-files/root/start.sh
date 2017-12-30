#!/bin/bash

cd /go/src/
# make your beego web server 
bee new beegoWeb
cd beegoWeb
go build
cp beegoWeb /var/www/
cp -fr views /var/www/
cp -fr static /var/www/
cp -fr conf /var/www/

chown -R www-data:www-data /var/www/
chmod -R 755 /var/www/

nohup /var/www/beegoWeb &
nginx