#!/bin/bash

## Package
yum install -y java-1.6.0 sudo tar zip unzip lsof vim file

## User and Group
groupadd -g 600 efs
useradd -g efs -u 6000 efs
useradd -g efs -c "EDW Feeder Server account" odt_sftp 

## Password
echo "efs:xxxxxx" |chpasswd
echo "odt_sftp:xxxxxx" |chpasswd
echo "root:xxxxxx" |chpasswd
chmod 770 /home/odt_sftp

## Sudo
sed -ri 's/Defaults    requiretty/#Defaults    requiretty/g' /etc/sudoers
sed -ri 's/Defaults   !visiblepw/#Defaults   !visiblepw/g' /etc/sudoers
echo "efs     ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

## Cronjob List
cat >/var/spool/cron/efs <<EOF
# efs crontab
# Initial create Jul-25-2014
1-29,31-59 * * * * /home/efs/logExtractor/bin/sftp_file_watcher.sh >> /home/efs/logExtractor/logs/sftp_file_\`date "+\%Y\%m"\`.log 2>&1
* * * * * /home/efs/logExtractor/bin/log-extractor.sh -u dfs -r suzdfsdc01:suzdfsdr01 -d /home/dfs/dfs/send/cfg/szz/out -c 15 >>  /home/efs/logExtractor/logs/log-extractor_\`date "+\%Y\%m"\`.log 2>&1
55 14 * * * /home/efs/logExtractor/bin/purge-data.sh >> /home/efs/logExtractor/logs/purge-datae_\`date "+\%Y\%m"\`.log 2>&1
EOF

chown efs:efs /var/spool/cron/efs
chmod 600 /var/spool/cron/efs
