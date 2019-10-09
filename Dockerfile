FROM alpine:3.8
LABEL maintainer="Klamas <klamas1@gmail.com>"

COPY install.sh run.sh backup.sh ./

RUN sh install.sh && rm install.sh;

ARG S3FS_VERSION=v1.79

RUN MYSQLDUMP_OPTIONS="--quote-names --quick --add-drop-table --add-locks --allow-keywords --disable-keys --extended-insert --single-transaction --create-options --comments --net_buffer_length=16384" \
    MYSQLDUMP_DATABASE="--all-databases" \
    MYSQL_HOST=**None** \
    MYSQL_PORT=3306 \
    MYSQL_USER=**None** \
    MYSQL_PASSWORD=**None** \
    S3_ACCESS_KEY_ID=**None** \
    S3_SECRET_ACCESS_KEY=**None** \
    S3_BUCKET=**None** \
    S3_REGION=us-west-1 \
    S3_ENDPOINT="https://s3.amazonaws.com" \
    S3_S3V4=no \
    S3_PREFIX="'"backup"'" \
    S3_FILENAME=**None** \
    IAM_ROLE=**None** \
    MOUNT_POINT=/var/s3 \
    MULTI_FILES=no \
    SCHEDULE=**None**

VOLUME /var/s3

CMD ["sh", "run.sh"]
