#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2022 Modamod
#
# startup.sh
# Description:
# Initializes the database and starts the snipeit app.
#
# Notes:
# Rerunning this script will update the db password for snipeit user with random passowrd each time.
#


restore_database() {
    mysql -u$1 -p$2 -h$3 -P$4  $5 < $6
}


: ${DB_HOST="mariabdb"}
: ${DB_PORT="3306"}
: ${OUTPUT="/workspaces/snipe-it/.gp/data/dump.sql"}
mysqluserpw="$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c16; echo)"
wait-port $DB_HOST:$DB_PORT
mysql -uroot -h$DB_HOST -p$MYSQL_ROOT_PASSWORD -P$DB_PORT -e  "CREATE DATABASE IF NOT EXISTS snipeit;GRANT ALL PRIVILEGES ON snipeit.* TO 'snipeit'@'mariadb'; FLUSH PRIVILEGES;"
if [[ ! $(mysql -uroot -h$DB_HOST -p$MYSQL_ROOT_PASSWORD -P$DB_PORT -e "SELECT 1 FROM users LIMIT 1;" snipeit) ]]; then
    echo "RESTORING"
    restore_database "snipeit" $DB_PASSWORD "$DB_HOST" "$DB_PORT" "snipeit" $OUTPUT
fi
cp -f /workspaces/snipe-it/.devcontainer/.env.docker .env
# sed -i "s|^\\(DB_PASSWORD=\\).*|\\1'${DB_PASSWORD}'|" .env
composer install
php artisan migrate --force
php artisan key:generate
