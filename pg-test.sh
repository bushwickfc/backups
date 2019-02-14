#!/bin/bash
set -ex
db=${1:?Missing db}
top_level=/home/members/bfc/sites/db.bushwickfoodcoop.org/users/dbbwickfood/backups
backup=$top_level/$db.bz2

if [ "$db" == "pos" ]
then
	# Back up the pos MySQL database
	user=${2:?Missing user}
	pass=${3:?Missing pass}
	host=${4:-pos.bushwickfoodcoop.org}
	tables=$(mysqlshow -u $user -p"$pass" -h $host $db \* | grep [A-Z][A-Z] | sed 's/[^_A-Z]//g')
	args="--tables $tables"

	mysqldump -u $user -p"$pass" -h $host $db $args | bzip2 > $backup
else
	# Back up the owners_db Postgres database
	oauth_token=${2:?Missing OAuth token}

	get_heroku_config() {
		echo $( curl -n https://api.heroku.com/apps/bfc-owners/config-vars -H "Authorization: Bearer $1" -H "Accept: application/vnd.heroku+json; version=3" )
	}

	heroku_config=$( get_heroku_config ${oauth_token} )
	# We receive the Heroku config as a JSON string, and will need to find the connection string inside.
	# The regex requires using a lookbehind, which does not work with grep unless the -P, --perl-regexp option is available.
	# I'm developing on a Mac, which doesn't have that option, and the Mayfirst server warns
	# "This is highly experimental and grep -P may warn of unimplemented features."
	# However, there is an alternative, which is to use the perl command -
	# https://stackoverflow.com/questions/16658333/grep-p-no-longer-works-how-can-i-rewrite-my-searches
	# The regex will grab the value of the connection string, stripping off the double quotes.
	pg_conn_string=$( echo $heroku_config | perl -nle'print $& while m{(?<="HEROKU_POSTGRESQL_COBALT_URL":")([^"]*)}g' | tail -1 )

	pg_dump $pg_conn_string | bzip2 > $backup
fi
