##
FROM centos:6.7

MAINTAINER Wei.Shen

## Base setting
RUN echo "proxy=http://10.40.3.249:3128" >> /etc/yum.conf
RUN ln -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo ZONE="Asia/Shanghai" > /etc/sysconfig/clock

## Supervisord, Cron, Postfix,
RUN yum -y install python-setuptools
ENV http_proxy=http://10.40.3.249:3128 
ENV https_proxy=http://10.40.3.249:3128
RUN easy_install supervisor
ADD ./dfs_supervisor.conf /etc/supervisor.conf
RUN yum -y install mailx ksh postfix

## Setup for DFS application
## perl, ksh ,java, mailx
RUN yum -y install perl ksh java-1.7.0 mailx perl-Compress-Zlib perl-IO-Zlib
RUN sed -ri 's/^#mydomain = domain.tld/^#mydomain = xxx.com/g' /etc/postfix/main.cf
## PG client
RUN rpm -ivh http://10.40.226.46:5665/postgresql93-libs-9.3.10-1PGDG.rhel6.x86_64.rpm  http://10.40.226.46:5665/postgresql93-9.3.10-1PGDG.rhel6.x86_64.rpm
## dfs user and group
RUN groupadd -g 600 dba
RUN groupadd -g 60090 sib
RUN useradd -g 600 -u 6000 -G 60090 dfs 
RUN echo "dfs:dfsdfs" |chpasswd
## NFS mount
RUN mkdir -p /mnt/sib && ln -s /mnt/sib /dataout
RUN mount suzdrprdnas01:/vol/sib /mnt/sib

ENTRYPOINT ["/usr/bin/supervisord","-c","/etc/supervisor.conf"]
