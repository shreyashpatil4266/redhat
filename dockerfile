FROM redhat/ubi8-minimal:latest

LABEL maintainer="Shreyash"
LABEL description="Apache HTTPD + PHP on UBI8 Minimal"

RUN microdnf update -y && \
    microdnf install -y httpd php php-cli php-common && \
    microdnf clean all && \
    echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf


EXPOSE 80

HEALTHCHECK CMD curl --fail http://localhost/ || exit 1

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

