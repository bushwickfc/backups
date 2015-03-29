#!/bin/bash
input=${1:?Missing input}
db=${2:?Missing db}
#bzip2 -dc $input | mysql -v -u backup -p'' $db
find /opt/backups -mtime +90 -delete
