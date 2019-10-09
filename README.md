# mysql-backup-s3

Backup MySQL to S3 (supports periodic backups & mutli files)

Use [s3fs](https://github.com/s3fs-fuse/s3fs-fuse) with Alpine Linux to mount an S3 bucket as a directory in the filesystem. This requires special permits for container ```--privileged --cap-add SYS_ADMIN --device /dev/fuse```

Use [rotate-backup](https://pypi.org/project/rotate-backups/) for backup rotation.


## Basic usage

```sh
$ docker run -e S3_ACCESS_KEY_ID=key -e S3_SECRET_ACCESS_KEY=secret -e S3_BUCKET=my-bucket -e S3_PREFIX=backup -e MYSQL_USER=user -e MYSQL_PASSWORD=password -e MYSQL_HOST=localhost ROTATE=yes klamas1/mysql-backup-s3:latest
```

## Environment variables

- `MYSQLDUMP_OPTIONS` mysqldump options (default: --quote-names --quick --add-drop-table --add-locks --allow-keywords --disable-keys --extended-insert --single-transaction --create-options --comments --net_buffer_length=16384)
- `MYSQLDUMP_DATABASE` list of databases you want to backup (default: --all-databases)
- `MYSQL_HOST` the mysql host *required*
- `MYSQL_PORT` the mysql port (default: 3306)
- `MYSQL_USER` the mysql user *required*
- `MYSQL_PASSWORD` the mysql password *required*
- `S3_ACCESS_KEY_ID` your AWS access key *required*
- `S3_SECRET_ACCESS_KEY` your AWS secret key *required*
- `S3_BUCKET` your AWS S3 bucket path *required*
- `S3_PREFIX` path prefix in your bucket (default: 'backup')
- `S3_REGION` the AWS S3 bucket region (default: us-west-1)
- `S3_ENDPOINT` the AWS Endpoint URL, for S3 Compliant APIs (default: none)
- `S3_ACL`  (default: private)
- `IAM_ROLE` IAM role name, for usage on EC2.
- `MULTI_FILES` Allow to have one file per database if set `yes` default: no)
- `SCHEDULE` backup schedule time, see explainatons below
- `ROTATE` Do you need to backup rotation (default: no)
- `ROTATE_PLAN` Keep backups in rotation (default: "-d6 -w3 -m3")


### Automatic Periodic Backups

You can additionally set the `SCHEDULE` environment variable like `-e SCHEDULE="@daily"` to run the backup automatically.

More information about the scheduling can be found [here](http://godoc.org/github.com/robfig/cron#hdr-Predefined_schedules).
