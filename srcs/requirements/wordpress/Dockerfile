FROM alpine:3.12 
# on alpine 3.14 !! nslookup (github) not working 

RUN apk update && 		   													   \
    apk add nginx curl mysql-client &&  									   \
    # apk add php7-fpm &&  													   \
    # apk add php7-mysqli; 													   \
    # installing for WP-CLI  												   \
    apk add gnupg php7 php7-phar php7-json php7-mbstring php7-bz2 php7-mysqli  \ 
    # installing for   		    											   \
    php7-fpm php7-common php7-iconv php7-json php7-gd 	   					   \
    php7-curl php7-xml php7-mysqli php7-imap php7-pdo php7-pdo_mysql 		   \
    php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap 	   \
    php7-ctype php7-dom php7-session php7-mbstring php7-redis							   \
	busybox-extras;  # telnet install 										   

#ENV TELEGRAF_VERSION 1.19.3
#ADD https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz .
#RUN mkdir -p /usr/src /etc/telegraf /run/nginx && 								   \
#    tar -C /usr/src -xzf telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz && \
#    mv /usr/src/telegraf*/etc/telegraf/telegraf.conf /etc/telegraf/ && \
#    mkdir /etc/telegraf/telegraf.d && \
#    cp -a /usr/src/telegraf*/usr/bin/telegraf /usr/bin/ && \
#    rm -rf *.tar.gz* /usr/src
#
#RUN telegraf --input-filter cpu:mem:net:nginx --output-filter influxdb config > /etc/telegraf/telegraf.conf; \
#sed -i 's*\# urls = \["http://127.0.0.1:8086"\]*urls = ["http://${INFLUX_URL}:8086"]*g' /etc/telegraf/telegraf.conf

WORKDIR /usr/src

RUN curl -OL http://wordpress.org/latest.tar.gz
#ADD http://wordpress.org/latest.tar.gz .
    
#ADD index.html .
ENV WORDPRESS_DB_USER root

RUN tar -xf latest.tar.gz -C .; \
	rm latest.tar.gz;

RUN curl -OL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/bin/wp
	# cd wordpress && \
	# wp core install --url=localhost:5050 --title=mysite --admin_user=bob --admin_password=1234 --admin_email=admin@ya.com --allow-root && \
	# wp user create hw h@m.com --allow-root && \
	# wp user create mob mob@m.com --allow-root
	#wp core install --url=localhost:5050 --title=mysite --admin_user=bob --admin_password=1234 --admin_email=admin@ya.com

#ADD nginx.conf /etc/nginx/conf.d/default.conf
WORKDIR /

ADD start.sh .
EXPOSE 9000

# CMD ["/bin/sh", "-c", "/usr/sbin/php-fpm7; exec nginx -g 'daemon off;';"]
CMD ["./start.sh"]
#CMD ["tail", "-f", "dev/null"]

#HEALTHCHECK --interval=1s --timeout=3s --start-period=5s CMD curl -f http://127.0.0.1/ || exit 1
