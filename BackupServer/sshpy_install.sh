## Install sshpt.py 
RUN yum -y install python-pip python-dev gcc
ENV http_proxy http://10.40.3.249:3128
ENV https_proxy http://10.40.3.249:3128

RUN pip install pycrypto
RUN pip install paramiko
RUN pip install 10.40.226.46:5665/sshpt-1.2.0.tar.gz 
