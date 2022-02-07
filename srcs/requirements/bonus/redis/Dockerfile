FROM alpine:3.12 
# on alpine 3.14 !! nslookup (github) not working 

RUN apk --update add curl php7-igbinary php7-redis redis \ 
    busybox-extras;  # telnet install 										   

WORKDIR /var/www/html

#ADD object-cache.php wordpress/wp-content/

ENV WORDPRESS_DB_USER root

WORKDIR /
ADD start.sh .

CMD ["./start.sh"]
#CMD ["tail", "-f", "dev/null"]

#HEALTHCHECK --interval=1s --timeout=3s --start-period=5s CMD curl -f http://127.0.0.1/ || exit 1
