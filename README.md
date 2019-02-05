# backups

Backup scripts for various databases.

## backup.sh

**backup.sh** goes on Mayfirst.

It is currently deployed at `/home/members/bfc/sites/db.bushwickfoodcoop.org/users/dbbwickfood/backup.sh` and writes backups to `/home/members/bfc/sites/db.bushwickfoodcoop.org/users/dbbwickfood/backups/$db.bz2`.

The backup is set to run as a cronjob by the user `dbbwick` daily at midnight with the following crontab command:

```
0 0 * * * /home/members/bfc/sites/db.bushwickfoodcoop.org/users/dbbwickfood/backup.sh $db $user $password
```

## cp-backup.sh

**cp-backup.sh** goes on Open Cirtuals
