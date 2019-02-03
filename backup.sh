#!/bin/bash
set -ex
db=${1:?Missing db}
user=${2:?Missing user}
pass=${3:?Missing pass}
host=${4:-viewsic.mayfirst.org}
top_level=/home/members/bfc/sites/db.bushwickfoodcoop.org/users/tmp/db.bushwickfoodcoop.org/backups
backup=$top_level/$db.bz2
if [ "$db" = "pos" ]; then
  tables=$(mysqlshow -u $user -p"$pass" -h $host $db \* | grep [A-Z][A-Z] | sed 's/[^_A-Z]//g')
  args="--tables $tables"
fi

mysqldump -u $user -p"$pass" -h $host $db $args | bzip2 > $backup
