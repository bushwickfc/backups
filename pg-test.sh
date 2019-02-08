#!/bin/bash
oauth_token=${1:?Missing OAuth token}

get_heroku_config() {
	echo $( curl -n https://api.heroku.com/apps/bfc-owners/config-vars -H "Authorization: Bearer $1" -H "Accept: application/vnd.heroku+json; version=3" )
}

heroku_config=$( get_heroku_config ${oauth_token} )

echo $heroku_config
