# backups

Backup scripts for various databases.

## backup.sh

**backup.sh** is hosted on Mayfirst, and it is used to back up the BFC's **pos** and **owners_db** databases, which are MySQL and Postgres, respectively.

The script is currently deployed at `/home/members/bfc/sites/db.bushwickfoodcoop.org/users/dbbwickfood/backup.sh` and writes backups to `/home/members/bfc/sites/db.bushwickfoodcoop.org/users/dbbwickfood/backups/$db.bz2`.

The backup is set to run as a cronjob by the user `dbbwick` daily at midnight with the following crontab command:

```crontab
0 0 * * * /home/members/bfc/sites/db.bushwickfoodcoop.org/users/dbbwickfood/backup.sh pos $user $password
0 0 * * * /home/members/bfc/sites/db.bushwickfoodcoop.org/users/dbbwickfood/backup.sh owners_db $oauth_token
```

### pos

The **pos** MySQL database is currently running on an AWS instance. To run the cronjob above, you'll need to provide values for the `$user` and `$password` arguments.

### owners_db

The **owners_db** Postgres database is currently running on Heroku. Heroku periodically rotates DB credentials, and so the first part of the backup script retrieves the latest configuration from Heroku and extracts the db connection string. In order to access the credentials via Heroku's platform API, the request will need to include an OAuth token associated with an account that has access to the database; thus, you'll need to provide a value for the `$oauth_token` argument in the cronjob.

To generate an OAuth token via the Heroku CLI, see https://devcenter.heroku.com/articles/platform-api-quickstart

To list your tokens via the Heroku CLI, run the command:

```bash
heroku authorizations
```

To see info (including the token itself) for a specific token, use the command:

```bash
heroku authorizations:info $TOKEN_ID
```

will show the info for that token.

## cp-backup.sh

As of 2/14/19, this script does not appear to be in use.

**cp-backup.sh** goes on Open Cirtuals.

## members-backups.sh

As of 2/14/19, this script does not appear to be in use.
