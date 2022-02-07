#!/bin/sh
#cd /var/www/html/wordpress
#echo "define('WP_CACHE_KEY_SALT', 'example.com');" >> wp-config.php 
#echo "define('WP_CACHE', true);" >> wp-config.php 
echo "maxmemory 256mb" >> /etc/redis.conf 
echo "maxmemory-policy allkeys-lru" >> /etc/redis.conf 
sed -i s/127.0.0.1/0.0.0.0/g /etc/redis.conf
redis-server /etc/redis.conf --protected-mode no
#redis-clu monitor
#tail -f dev/null
