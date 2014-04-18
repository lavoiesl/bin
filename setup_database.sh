#!/bin/sh

if ! echo $1 | grep -q '^wmc_.'; then
    echo "*** Usage: $0 wmc_database" >&2
    exit 1
fi

if [[ ! -d "./confs" ]]; then
    echo "*** Current folder must have a 'confs' folder" >&2
    exit 2
fi

database="$1"

echo "host=\"localhost\"
user=\"wmc\"
pass=\"wmc\"
name=\"$database\"" > confs/database.ini

echo "CREATE DATABASE IF NOT EXISTS \`$database\`;" | mysql

if [[ -n "$(git ls-files --other --exclude-standard confs/database.ini)" ]]; then
    echo "WARNING: confs/database.ini is not currently ignored" >&2
fi
