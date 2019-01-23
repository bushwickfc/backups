#!/bin/bash
db="owners_db"
backup="/Users/darrenklein/Desktop/$db.bz2"

pg_dump $db | bzip2 > $backup
