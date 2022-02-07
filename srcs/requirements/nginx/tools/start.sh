#!/bin/sh
cd /etc/nginx/
openssl req -x509 -newkey rsa:4096 -nodes -keyout localhost.key -out localhost.crt -days 365 -subj '/CN=localhost'
echo "hello : )"

#tail -f /dev/null
nginx -g 'daemon off;'
#wait -n 
#exit $?
# tail -f /dev/null
