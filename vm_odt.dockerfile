##
FROM centos:6.7

MAINTAINER Wei.Shen

## Base setting
RUN echo "proxy=http://10.40.3.249:3128" >> /etc/yum.conf
RUN ln -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo ZONE="Asia/Shanghai" > /etc/sysconfig/clock

## SSH and basic command
RUN yum -y install openssh-server openssh-clients passwd which ping

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' 
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
RUN echo "root:Passw0rd2016" |chpasswd
EXPOSE 22

## Supervisord, Cron, Postfix,
RUN yum -y install python-setuptools
ENV http_proxy=http://10.40.3.249:3128 
ENV https_proxy=http://10.40.3.249:3128
RUN easy_install supervisor
ADD ./vm_odt_supervisor.conf /etc/supervisor.conf
RUN yum -y install vixie-cron mailx ksh postfix

## ODT App related
ADD ./vm_odt_app.sh /vm_odt_app.sh
RUN chmod 755 /vm_odt_app.sh
RUN /vm_odt_app.sh

ENTRYPOINT ["/usr/bin/supervisord","-c","/etc/supervisor.conf"]

