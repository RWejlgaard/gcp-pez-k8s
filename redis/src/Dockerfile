FROM redis

ADD redis.conf /etc/redis.conf

ENTRYPOINT ["sh", "-c", "exec redis-server /etc/redis.conf --requirepass \"$REDIS_PASSWORD\""]