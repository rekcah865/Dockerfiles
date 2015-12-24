## Prepartion
mkdir -p /vol/BackupServer
chown docker:docker /vol/vol/BackupServer

## Build image
docker build --rm -t bks:centos6v1 .

## Run Container
docker run -d -l BackupServer --name BackupServer --hostname BackupServer -p 2201:22 -P -v /vol/BackupServer:/home/bkpusr bks:centos6v1
