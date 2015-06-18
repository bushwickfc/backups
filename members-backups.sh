#!/bin/bash
set -ex
db=bfc-members_production
user=backup
latest=/opt/backups/members-latest
backup=/opt/backups/$(date +%s)-members.sql.bz2
mysqldump -u $user $db $args | bzip2 > $backup
rm -f $latest
ln -sf $backup $latest
scp $latest bushwickfoodcoop@june.mayfirst.org:backups/${latest##*/}.sql.bz2
find /opt/backups/ -name \*members\* -mtime +10 -delete
