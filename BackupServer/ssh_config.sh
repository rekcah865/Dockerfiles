## Basic tool (SSH)
RUN yum -y install openssh-server openssh-clients passwd 
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' 
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
RUN echo "root:Passw0rd2016" |chpasswd

EXPOSE 22
