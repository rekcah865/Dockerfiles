## prepare FFS software 
## ./FISFactoryServices/
## ./scripts/

## create volume directory for log and app
## mkdir -p /vol/app /vol/log
## chown docker:docker /vol/app vol/log

## build image
docker build --rm -t ffs1:centos6 ./ffs1.dockerfile

## Sample for container Docker01FFS05
mkdir -p /vol/app/Docker01FFS05
#### edit the configuration file under app folder
## sample: ***.ini, ***.plugin
## Run container
docker run -d -l Docker01FFS05 --name=Docker01FFS05 --net=host -v /vol/log:/s01/log -v /vol/app/Docker01FFS05/:/s01/FISFactoryServices/ ffs1:centos6

## End
