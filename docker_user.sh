# It's to create Docker user on server

groupadd -g 600 docker
groupmod -g 600 docker
useradd -u 6000 -g docker -G root docker
## usermod -G root docker

echo "docker  ALL=(ALL)       NOPASSWD:ALL" >> /etc/sudoers
