#!/bin/sh

# install s3fs-fuse
apk add fuse alpine-sdk automake autoconf libxml2-dev fuse-dev curl-dev git bash;
git clone https://github.com/s3fs-fuse/s3fs-fuse.git;
cd s3fs-fuse;
git checkout tags/${S3FS_VERSION};
./autogen.sh;
./configure --prefix=/usr;
make;
make install;

# install mysqldump
apk add mysql-client

# install s3 tools
apk add python py-pip
pip install rotate-backups-s3
apk del py-pip

# install go-cron
apk add curl
curl -L --insecure https://github.com/odise/go-cron/releases/download/v0.0.6/go-cron-linux.gz | zcat > /usr/local/bin/go-cron
chmod u+x /usr/local/bin/go-cron
apk del curl

# cleanup
rm -rf /var/cache/apk/*
