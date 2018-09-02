#! /bin/sh

# Load tab delimited file into SQLite

set -x

file=$1
table=$2
database=$3

printf ".mode tab\n.import $file $table\n" sqlite3 $database

