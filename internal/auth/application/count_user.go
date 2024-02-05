package application

import (
	"context"
	"fmt"
)

const CountPing = "ping_count_user"

func (s *authServ) AddPingCountUser(id int64) error {
	ctx := context.Background()
	key := fmt.Sprintf("%d", id)
	err := s.rdb.PFAdd(ctx, CountPing, key).Err()
	return err
}

func (s *authServ) GetCountUser() (int64, error) {
	ctx := context.Background()
	rs, err := s.rdb.PFCount(ctx, CountPing).Result()
	return rs, err
}
