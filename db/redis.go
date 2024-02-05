package db

import (
	"context"
	"learn-redis/config"

	"github.com/redis/go-redis/v9"
)

func ConnectionRedis(conf config.Config) (*redis.Client, error) {
	rdb := redis.NewClient(&redis.Options{
		Addr: conf.RedisUrl,
	})
	ctx := context.Background()
	err := rdb.Ping(ctx).Err()
	return rdb, err
}
