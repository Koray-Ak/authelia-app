#!/bin/bash

data=`echo | openssl s_client -servername $1 -connect $1:${2:-443} 2>/dev/null | openssl x509 -noout -enddate | sed -e 's#notAfter=##'`
ssldate=`date -d "${data}" '+%s'`
nowdate=`date '+%s'`
diff="$((${ssldate}-${nowdate}))"

www=/var/www/html
letsencrypt=/etc/letsencrypt
log=/var/log/letsencrypt
network=~/authelia-app
email=mail@mail.com

if [ $((${diff}/86400)) -lt 21 ]; then
  docker run -it --rm --name certbot \
           -v "$network/nginx-config/www:$www" \
           -v "$network/letsencrypt/:$letsencrypt" \
           -v "$network/log:$log" \
           certbot/certbot certonly --webroot -w $www -d $1 --email $email --agree-tos
fi
