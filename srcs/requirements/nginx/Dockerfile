FROM alpine:3.14


RUN apk update && \
    apk add nginx busybox-extras curl openssl;
	# touch /var/log/nginx/access.log ; \
	# touch /var/log/nginx/error.log ; \
	# ln -sf 	  /dev/stdout /var/log/nginx/access.log \
    # && ln -sf /dev/stderr /var/log/nginx/error.log
    # mkdir /run/nginx;
	# https://serverfault.com/questions/599103/make-a-docker-application-write-to-stdout/634296#634296

# ADD start.sh .

#ENV TELEGRAF_VERSION 1.19.3
#ADD https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz .
#RUN mkdir -p /usr/src /etc/telegraf && \
#    tar -C /usr/src -xzf telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz && \
#    mv /usr/src/telegraf*/etc/telegraf/telegraf.conf /etc/telegraf/ && \
#    mkdir /etc/telegraf/telegraf.d && \
#    cp -a /usr/src/telegraf*/usr/bin/telegraf /usr/bin/ && \
#    rm -rf *.tar.gz* /usr/src
#
#RUN telegraf --input-filter cpu:mem:net --output-filter influxdb config > /etc/telegraf/telegraf.conf; \
#	sed -i 's*\# urls = \["http://127.0.0.1:8086"\]*urls = ["http://${INFLUX_URL}:8086"]*g' /etc/telegraf/telegraf.conf

ADD conf /etc/nginx/http.d/default.conf

#EXPOSE 80
EXPOSE 443
COPY tools/start.sh start.sh
# CMD ["/bin/sh", "-c", "/usr/sbin/php-fpm7; exec nginx -g 'daemon off;';"]
CMD ["./start.sh"]
# CMD ["nginx", "-g", "daemon off;"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s CMD curl -f http://127.0.0.1/ || exit 1
