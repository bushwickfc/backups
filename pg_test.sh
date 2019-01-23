#!/bin/bash
db="circles_analytics"
backup="/Users/darrenklein/Desktop/$db.bz2"

pg_dump $db | bzip2 > $backup
