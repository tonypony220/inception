#!/bin/sh
#tail -f /dev/null
mkdir -p /var/www/html/wordpress
cp -r /usr/src/* /var/www/html/
cd /var/www/html/wordpress
#ls /usr/src
#if [ ! -e index.php ] && [ ! -e wp-includes/version.php ]; then
#		echo "FUCK!"
#		cp -r /usr/src/wordpess /var/www/html/wordpress
#fi

#false to true in debug statement
sed s/username_here/${WORDPRESS_DB_USER}/ wp-config-sample.php | \
sed s/database_name_here/${WORDPRESS_DB_NAME}/ | 		 \
sed s/password_here/${WORDPRESS_DB_PASSWORD}/ |  	         \
sed s/false/true/ | 					         \
sed s/localhost/${WORDPRESS_DB_HOST}/ > wp-config.php
#sed s/"define( 'NONCE_SALT',       'put your unique phrase here' );"/"define( 'NONCE_SALT',       'put your unique phrase here' );\ndefine('WP_CACHE_KEY_SALT', 'example.com');\ndefine('WP_CACHE', true);\n"/ > wp-config.php

#echo "define('WP_CACHE_KEY_SALT', 'example.com');" >> wp-config.php 
#echo "define('WP_CACHE', true);" >> wp-config.php 

# echo "<?php phpinfo() ?>" > index.php; \
# chmod -R 755 .;
sed -i s/127.0.0.1/0.0.0.0/g /etc/php7/php-fpm.d/www.conf

wp core install --url=https://94.154.11.107 --title=mysite --admin_user=bob --admin_password=1234 --admin_email=admin@ya.com --allow-root #0.0.0.0:9000
wp user create hw h@m.com --allow-root
wp plugin install redis-cache --allow-root
wp plugin activate redis-cache --allow-root
sed -i s/127.0.0.1/redis/g /var/www/html/wordpress/wp-content/object-cache.php
wp redis enable --force --allow-root
#wp config set WP_REDIS_PATH --raw "__DIR__ . '/../redis.sock'"
#wp config set WP_REDIS_SCHEME "unix"
#wp plugin install redis-cache --activate

#wp user create mob mob@m.com --allow-root
#php-fpm7
php-fpm7 -F -R # -F, --nodaemonize  -R, --allow-to-run-as-root

#: adding user
# https://stackoverflow.com/questions/15872543/access-mysql-remote-database-from-command-line
# mysql -u$WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD -h${WORDPRESS_DB_HOST} << eof
# INSERT INTO ${WORDPRESS_DB_NAME}.`wp_users` (`ID`, `user_login`, `user_pass`, `user_nicename`, `user_email`, `user_status`, `display_name`) VALUES ('1000', 'tempuser', MD5('Str0ngPa55!'), 'tempuser', 'support@wpwhitesecurity.com', '0', 'Temp User');
# INSERT INTO ${WORDPRESS_DB_NAME}.`wp_usermeta` (`umeta_id`, `user_id`, `meta_key`, `meta_value`) VALUES (NULL, '1000', 'wp_capabilities', 'a:1:{s:13:"administrator";b:1;}');
# INSERT INTO ${WORDPRESS_DB_NAME}.`wp_usermeta` (`umeta_id`, `user_id`, `meta_key`, `meta_value`) VALUES (NULL, '1000', 'wp_user_level', '10');
# eof

#telegraf&
#nginx -g 'daemon off;'
#wait -n 
# tail -f /dev/null
