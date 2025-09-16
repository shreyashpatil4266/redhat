FROM redhat/ubi8-minimal:latest

LABEL maintainer="Shreyash"
LABEL description="Apache HTTPD + PHP on UBI8 Minimal"

# Install Apache and PHP using microdnf
RUN microdnf update -y && \
    microdnf install -y httpd php php-cli php-common && \
    microdnf clean all && \
    echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf

# Optional: Copy your PHP app files
# COPY ./src/ /var/www/html/

# Expose HTTP port
EXPOSE 80

# Healthcheck to ensure Apache is running
HEALTHCHECK CMD curl --fail http://localhost/ || exit 1

# Start Apache in foreground
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

