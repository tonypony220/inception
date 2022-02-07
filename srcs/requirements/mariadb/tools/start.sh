#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
	chgrp -R mysql /var/lib/mysql
fi

if [ -d /var/lib/mysql/mysql ]; then
	echo '[i] MySQL directory already present, skipping creation'
else
	echo "[i] MySQL data directory not found, creating initial DBs"

	chown -R mysql:mysql /var/lib/mysql
	#https://github.com/docker-library/mysql/blob/15fe7357b165ee8aaa3ce165386f910a53a75087/8.0/Dockerfile.debian
	# official also make 777 
	chmod -R 777 /var/lib/mysql

	# init database
	echo 'Initializing database'
	mysql_install_db --user=mysql --datadir=/var/lib/mysql --basedir=/usr/ --ldata=/var/lib/mysql/ > /dev/null # datadir spec !!!!
	# https://stackoverflow.com/questions/47075429/error-setting-up-mysql-table-mysql-plugin-doesnt-exist
	echo 'Database initialized'

	echo "[i] MySql root password: $MYSQL_ROOT_PASSWORD"

	# create temp file
	tfile=`mktemp`
	if [ ! -f "$tfile" ]; then
	    return 1
	fi

	# save sql
	echo "[i] Create temp file: $tfile"
	cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;
GRANT SELECT, SHOW VIEW, PROCESS ON *.* TO '$MYSQL_USER_MONITORING'@'%' IDENTIFIED BY '$MYSQL_PASSWORD_MONITORING' WITH GRANT OPTION;
EOF
# DELETE FROM mysql.user;
#https://stackoverflow.com/questions/14779104/mysql-how-to-allow-remote-connection-to-mysql


	# Create new database
	if [ "$MYSQL_DATABASE" != "" ]; then
		echo "[i] Creating database: $MYSQL_DATABASE"
		echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tfile

		# set new User and Password
		if [ "$MYSQL_USER" != "" ] && [ "$MYSQL_PASSWORD" != "" ]; then
		echo "[i] Creating user: $MYSQL_USER with password $MYSQL_PASSWORD"
		echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
		fi
	else
		# don`t need to create new database,Set new User to control all database.
		if [ "$MYSQL_USER" != "" ] && [ "$MYSQL_PASSWORD" != "" ]; then
		echo "[i] Creating user: $MYSQL_USER with password $MYSQL_PASSWORD"
		echo "GRANT ALL ON *.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
		fi
	fi

	echo 'FLUSH PRIVILEGES;' >> $tfile

	# run sql in tempfile
	echo "[i] run tempfile: $tfile"
	/usr/bin/mysqld --user=mysql --bootstrap --verbose=0 < $tfile
	# rm -f $tfile
fi

echo "[i] Sleeping 5 sec"
sleep 5

#echo "Starting all process"
#telegraf&
exec /usr/bin/mysqld --user=mysql #--console
# tail -f /dev/null
#wait -n 


