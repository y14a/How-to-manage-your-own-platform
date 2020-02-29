FROM    centos:7

RUN     yum -y install centos-release-openstack-rocky
RUN     yum -y install openstack-keystone httpd mod_wsgi

COPY    keystone.conf /etc/keystone/keystone.conf
RUN     ln -s /usr/share/keystone/wsgi-keystone.conf /etc/httpd/conf.d/