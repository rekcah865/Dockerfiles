### GPS1 is just for one running testing for GetPut service
## Because the configuration file is in container, 
##- it would disappear after container stop or restart

## prepare GPS software and configure script
## ./FISGetPutServer/
## ./gps_scripts/
## ./gps1_config.sh


## create volume directory for log 
## mkdir -p /vol/log 

## build image
docker build --rm -t gps1:centos6 -f gps1.dockerfile .

## Sample for container GPS01
## create environment file for GPS01
cat > gps01.env <<EOF
PRIMARYAGENT=10.40.100.126
PRIMARYAGENTPORT=4915
SECONDARYAGENT=10.40.100.126
SECONDARYAGENTPORT=4915
TERTIARYAGENT=10.40.100.126
TERTIARYAGENTPORT=4915
LISTENPORT=2915
CLIENTPORT=2916
EOF

## Run container
docker run -d -l GPS01 --name=GPS01 --net=host -p 2915:2915 -p 2916:2916 --env-file=./gps01.env gps1:centos6

## End
