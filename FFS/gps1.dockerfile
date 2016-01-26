##
FROM centos:6.7

MAINTAINER Wei.Shen

## Base setting
RUN echo "proxy=http://10.40.3.249:3128" >> /etc/yum.conf
RUN ln -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo ZONE="Asia/Shanghai" > /etc/sysconfig/clock

## Java install
RUN yum -y install java-1.7.0 telnet

## GetputService application
RUN groupadd -g 600 suz
RUN useradd -g 600 -u 6000 suz 
ADD ./gps_scripts /home/suz/scripts/
RUN mkdir -p /s01/FISGetPutServer /s01/log
RUN chown -R suz:suz /home/suz/scripts /s01/FISGetPutServer

## GetputService configuration
ADD ./gps1_config.sh /gps1_config.sh
RUN chmod +x /gps1_config.sh && /gps1_config.sh

ENTRYPOINT su - suz -c "/home/suz/scripts/fisgps.sh -start -a 731"
