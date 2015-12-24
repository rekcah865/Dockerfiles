## Install supervisor

RUN yum -y install python-setuptools
ENV http_proxy http://10.40.3.249:3128 
ENV https_proxy http://10.40.3.249:3128
RUN easy_install supervisor
ADD ./supervisor.conf /etc/supervisor.conf
