.PHONY: build push shell all

all: build release

build:
	@docker build -t klamas1/mysql-backup-s3:latest .

release:
	@docker push klamas1/mysql-backup-s3:latest

shell:
	@docker run -t -i klamas1/mysql-backup-s3:latest /bin/bash
