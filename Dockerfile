FROM centos:7
MAINTAINER The CentOS Project <cloud-ops@centos.org>
LABEL Vendor="CentOS" \
      License=GPLv2 \
      Version=2.4.6-40


RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install httpd && \
    yum clean all

ENV APACHE_LOG_PATH=/var/log/httpd24

EXPOSE 80

# Simple startup script to avoid some issues observed with container restart
ADD run-httpd.sh /run-httpd.sh
ADD index.html /var/www/html/index.html
ADD site.conf /etc/httpd/conf.d/site.conf
RUN chmod -v +x /run-httpd.sh

RUN mkdir /var/log/httpd24
RUN chmod -R a+rwx /run/httpd
RUN chmod -R a+rwx /var/log/httpd24
RUN chmod -R a+rwx /var/www
RUN chmod -R a+rwx /etc/httpd


CMD ["/run-httpd.sh"]
