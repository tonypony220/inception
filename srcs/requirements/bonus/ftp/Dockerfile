FROM alpine:3.14
# https://github.com/delfer/docker-alpine-ftp-server
# https://mikestechblog.com/vsftpd-refusing-to-run-with-writable-root-inside-chroot/
RUN apk --no-cache add vsftpd # openssl # vim lftp su-exec
#SSL_connect: sslv3 alert handshake failure

COPY start_vsftpd.sh /bin/start_vsftpd.sh
COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
#COPY lftp.ssl.commands /
#COPY sc.bash /

EXPOSE 21
# 21000-21010
STOPSIGNAL SIGKILL

ENTRYPOINT ["/bin/start_vsftpd.sh"]
