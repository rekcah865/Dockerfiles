##
FROM centos:6.7

MAINTAINER Wei.Shen

## Base setting
RUN echo "proxy=http://10.40.3.249:3128" >> /etc/yum.conf
RUN ln -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo ZONE="Asia/Shanghai" > /etc/sysconfig/clock

## Java install
RUN yum -y install java-1.7.0

## Suz user for ffs
RUN groupadd -g 600 suz
RUN useradd -g 600 -u 6000 suz 
ADD ./scripts /home/suz/scripts/
RUN mkdir -p /s01/log /s01/FISFactoryServices
RUN chown -R suz:suz /s01/log /home/suz/scripts /s01/FISFactoryServices

EXPOSE 5915 5916 8086
ENTRYPOINT su - suz -c "/home/suz/scripts/FISFactoryService.sh -start"


