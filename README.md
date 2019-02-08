# backups

Backup scripts for various databases.

## backup.sh

**backup.sh** goes on Mayfirst.

It is currently deployed at `/home/members/bfc/sites/db.bushwickfoodcoop.org/users/dbbwickfood/backup.sh` and writes backups to `/home/members/bfc/sites/db.bushwickfoodcoop.org/users/dbbwickfood/backups/$db.bz2`.

The backup is set to run as a cronjob by the user `dbbwick` daily at midnight with the following crontab command:

```
0 0 * * * /home/members/bfc/sites/db.bushwickfoodcoop.org/users/dbbwickfood/backup.sh $db $user $password
```

### owners_db - WORK IN PROGRESS

The **owners_db** Postgres database is currently running on Heroku. Heroku periodically rotates DB credentials, and so the first part of the backup script retrieves those credentials from Heroku.

In order to access the credentials via Heroku's platform API, the request will need to include an OAuth token associated with an account that has access to the database.

To generate an OAuth token via the Heroku CLI, see https://devcenter.heroku.com/articles/platform-api-quickstart

The command

```bash
heroku authorizations
```

will list all current tokens.

```bash
heroku authorizations:info $TOKEN_ID
```

will show the info for that token.

At the moment, experimenting with running this with bash and Python. So the command is either

```bash
./pg-test.sh $oauth_token
```

or

```bash
python3 pg-test.py $oauth_token
```

## cp-backup.sh

**cp-backup.sh** goes on Open Cirtuals
