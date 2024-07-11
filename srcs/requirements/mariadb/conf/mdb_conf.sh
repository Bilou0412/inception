#!/bin/bash

service mariadb start
sleep 5

mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MARIADB}\`;"
mariadb -e "CREATE USER IF NOT EXISTS \`${MARIADB_U}\`@'%' IDENTIFIED BY '${MARIADB_PASS}';"
mariadb -e "GRANT ALL PRIVILEGES ON ${MARIADB}.* TO \`${MARIADB_U}\`@'%';"
mariadb -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p$MARIADB_ROOT_PASS shutdown
mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'
