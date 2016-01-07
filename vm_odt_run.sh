## Build image

docker build --rm -t vm_odtv1:centos6 ./vm_odt.dockerfile

## Prepare ODT application
mkdir -p /vol/app/suzodt
# tar -xf /tmp/efs.tar /vol/app/suzodt

## Run container
docker run -d -l suzodt --name=suzodt --hostname=suzodt --add-host="wxdpefs:10.38.197.207" --add-host="tkddo-odt01 tkdpefs:10.8.132.2" -p 2201:22 -P -v /vol/app/suzodt:/home/efs

## End
