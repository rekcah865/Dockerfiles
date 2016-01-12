## It's to prepare to docker environment for containers

############ Docker user
groupadd -g 600 docker
#groupmod -g 600 docker
useradd -u 6000 -g docker -G root docker
# useradd -u 6000 -g docker -G root -d /u01/usr/docker docker
# usermod -G root docker
# echo "docker:xxxxxx" |chpasswd
echo "docker  ALL=(ALL)       NOPASSWD:ALL" >> /etc/sudoers

# mkdir -p /vol/app /vol/log && chown -R docker:docker /vol/app /vol/log

############ Docker package
wget http://10.40.226.46:5665/docker-engine-1.7.1-1.el6.x86_64.rpm
rpm -ivh docker-engine-1.7.1-1.el6.x86_64.rpm
cat >> /etc/sysconfig/docker  <<EOF
export HTTP_PROXY=http://10.40.3.249:3128
export HTTPS_PROXY=http://10.40.3.249:3128
EOF
service docker start && chkconfig docker on

############ Docker centos6.7 image
## su - docker
docker pull centos:6.7 
docker images
#REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
#centos              6.7                 3fba1048142f        3 months ago        190.6 MB

