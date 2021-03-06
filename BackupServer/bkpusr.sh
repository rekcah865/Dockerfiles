## Create bkpusr account

groupadd -g 600 bkpusr
useradd -g bkpusr -c "Backup User" bkpusr
echo "bkpusr:Bkpusr2016" |chpasswd

echo "bkpusr     ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

## Setup bkpusr cronjob
cat > /var/spool/cron/bkpusr << EOF

EOF

chown bkpusr:bkpusr /var/spool/cron/bkpusr
chmod 600 /var/spool/cron/bkpusr

## Setup cronjob
RUN yum -y install vixie-cron mailx ksh postfix

## Mount GlusterFS storage
RUN mkdir -p /bkp_glfs && mount suzglfs:/szbkp-vol /bkp_glfs
