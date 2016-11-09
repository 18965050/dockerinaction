FROM docker.vemic.com/insxyz/redis:3.2.4
ADD ./redis.conf /usr/local/etc/redis/redis.conf
USER redis
CMD ["redis-server","/usr/local/etc/redis/redis.conf"]