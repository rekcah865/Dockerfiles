### GPS2 is just for running testing for GetPut service with volume
## Because the configuration file, Log, Queue file is in host, 
##- All would still keep after container stop or restart

## prepare GPS software for build image 
## ./FISGetPutServer/

## build image
docker build --rm -t gps2:centos6 -f gps2.dockerfile .

## create volume directory for configuration file, log, Queue file
## Sample - GPS02
sudo mkdir -p /vol/gps/GPS02
sudo chown docker:docker /vol/gps/GPS02
cd /vol/gps/GPS02 && mkdir -p GETPUTSERVER/DiskQueue/default GETPUTSERVER/NoRouteDiskQueue Logs
cat > /vol/gps/GPS02/GetPutServer.srv <<EOF
FCAUSAGE=OFF
FCASERVER=
FCASERVERPORT=

NAME=GPS02
PRIMARYAGENT=10.40.100.126
PRIMARYAGENTPORT=4915
SECONDARYAGENT=10.40.100.126
SECONDARYAGENTPORT=4915
TERTIARYAGENT=10.40.100.126
TERTIARYAGENTPORT=4915
LISTENPORT=2917
CLIENTPORT=2918

ACKNOWLEDGEPUTS=true
AGENTQUEUELIMIT=1000
AGENTQUEUEMANAGEMENT=true
ALERTSYSTEM=true
STATUSINTERVAL=15
ALERTSEVERITYLIMIT=7500
ALERTRATELIMIT=10

AGENTBUFFERSIZE=32768
TESTERBUFFERSIZE=8192
SYSTEMTIMEUPDATEINTERVAL=15
GATEWAYGROUPS=DEFAULT
AGENTGROUPS=NONE

EOF


## Run container
docker run -d -l GPS02 --name=GPS02 --net=host \
-v /vol/gps/GPS02/GETPUTSERVER:/s01/FISGetPutServer/731/GETPUTSERVER \
-v /vol/gps/GPS02/Logs:/s01/FISGetPutServer/731/Logs \
-v /vol/gps/GPS02/GetPutServer.srv:/s01/FISGetPutServer/731/GetPutServer.srv gps2:centos6

## End
