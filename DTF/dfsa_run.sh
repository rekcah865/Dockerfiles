## It's to run DFSa container

## Build image

docker build --rm -t dfs_v1:centos6 -f dfs.dockerfile -m 4G .

## Prepare DFS application
mkdir -p /vol/app/dfsa
# tar -xf /tmp/dfs.tar /vol/app/dfsa

## Run container
docker run -d -l dfsa --name=dfsa --net=host -v /vol/app/dfsa:/home/dfs dfs_v1:centos6

## End
