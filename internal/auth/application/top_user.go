package application

import (
	"context"
	"learn-redis/internal/auth/domain"
	"strconv"

	"github.com/redis/go-redis/v9"
)

func (s *authServ) GetTopUser(limit int) ([]domain.UserItemTopUser, error) {
	ctx := context.Background()
	listZ, err := s.rdb.ZRevRangeByScoreWithScores(ctx, CountUserPingKey, &redis.ZRangeBy{
		Offset: 0,
		Count:  int64(limit),
	}).Result()
	if err != nil {
		return nil, err
	}
	topUser := make([]domain.UserItemTopUser, len(listZ))
	for i, v := range listZ {
		var user domain.User
		idStr := v.Member.(string)
		id, ok := strconv.Atoi(idStr)
		if ok != nil {
			return nil, ok
		}
		if err := s.db.Find(&user, id).Error; err != nil {
			return nil, err
		}
		item := domain.UserItemTopUser{
			User:  user,
			Count: int64(v.Score),
		}
		topUser[i] = item

	}
	return topUser, nil
}
