FROM alpine:3.8
LABEL maintainer="Klamas <klamas1@gmail.com>"

ARG S3FS_VERSION=v1.85

ENV MYSQLDUMP_OPTIONS="--quote-names --quick --add-drop-table --add-locks --allow-keywords --disable-keys --extended-insert --single-transaction --create-options --comments --net_buffer_length=16384" \
    MYSQLDUMP_DATABASE="--all-databases" \
    MYSQL_HOST="**None**" \
    MYSQL_PORT="3306" \
    MYSQL_USER="**None**" \
    MYSQL_PASSWORD="**None**" \
    S3_ACCESS_KEY_ID="**None**" \
    S3_SECRET_ACCESS_KEY="**None**" \
    S3_BUCKET="**None**" \
    S3_REGION="us-west-1" \
    S3_ENDPOINT="https://s3.amazonaws.com" \
    S3_PREFIX="backup" \
    IAM_ROLE="**None**" \
    MOUNT_POINT="/var/s3" \
    MULTI_FILES="no" \
    SCHEDULE="**None**" \
    ROTATE="**None**" \
    ROTATE_PLAN="-d6 -w3 -m3"
    #instructions https://pypi.org/project/rotate-backups/

COPY install.sh run.sh backup.sh ./

RUN sh install.sh && rm install.sh;

VOLUME /var/s3

CMD ["sh", "run.sh"]
