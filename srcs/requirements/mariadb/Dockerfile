FROM alpine:3.14

ENV MYSQL_ROOT_PASSWORD root
ENV MYSQL_DATABASE app
ENV MYSQL_USER app
ENV MYSQL_PASSWORD app
ENV MYSQL_USER_MONITORING monitoring
ENV MYSQL_PASSWORD_MONITORING monitoring

RUN apk update && apk add --no-cache mysql mysql-client 
RUN addgroup mysql mysql


COPY tools/start.sh start.sh
# don't know wtf config not int mysql dir despite it is. 
# https://serverfault.com/questions/688513/cant-access-mysql-docker-container-from-the-host
COPY conf /etc/my.cnf.d/mariadb-server.cnf

VOLUME [ "/var/lib/mysql" ]

EXPOSE 3306

#ENV TELEGRAF_VERSION 1.19.3
#ADD https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz .
#RUN mkdir -p /usr/src /etc/telegraf && \
#    tar -C /usr/src -xzf telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz && \
#    mv /usr/src/telegraf*/etc/telegraf/telegraf.conf /etc/telegraf/ && \
#    mkdir /etc/telegraf/telegraf.d && \
#    cp -a /usr/src/telegraf*/usr/bin/telegraf /usr/bin/ && \
#    rm -rf *.tar.gz* /usr/src

#RUN telegraf --input-filter cpu:mem:net --output-filter influxdb config > /etc/telegraf/telegraf.conf; \
#	sed -i 's*\# urls = \["http://127.0.0.1:8086"\]*urls = ["http://${INFLUX_URL}:8086"]*g' /etc/telegraf/telegraf.conf

ENTRYPOINT [ "./start.sh" ]

HEALTHCHECK --interval=1s --timeout=3s --start-period=6s CMD mysqladmin ping -h localhost || exit 1
