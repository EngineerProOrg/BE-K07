package application

import (
	"context"
	"errors"
	"fmt"
	"learn-redis/internal/auth/domain"
	"time"

	"github.com/redis/go-redis/v9"
	"gorm.io/gorm"
)

type authServ struct {
	db  *gorm.DB
	rdb *redis.Client
}

func NewAuthServ(db *gorm.DB, rdb *redis.Client) *authServ {
	return &authServ{
		db:  db,
		rdb: rdb,
	}
}

func (s *authServ) FindUser(email string) (*domain.User, error) {
	var user *domain.User
	err := s.db.Where("email = ?", email).First(user).Error
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, ErrUserNotFound
	}
	if err != nil {
		// log error
		return nil, ErrDBInternal
	}
	return user, err
}

func (s *authServ) CreateUser(email, pass, firstName, lastName string) (*domain.User, error) {
	user := domain.NewUser(email, pass, firstName, lastName)
	err := s.db.Create(user).Error
	if err != nil {
		// log error
		return nil, ErrDBInternal
	}
	return user, err
}

func (s *authServ) Login(email, pass string) (sessionId string, err error) {
	var user *domain.User
	user, err = s.FindUser(email)
	if err != nil {
		return "", err
	}
	verifyPass := user.VerifyPass(pass)
	if !verifyPass {
		return "", ErrAuth
	}
	key := fmt.Sprintf("session_%d", time.Now().UnixNano())
	s.rdb.Set(context.Background(), key, *user, 2*time.Hour)
	return key, nil
}

func (s *authServ) GetUserFromSession(session string) (*domain.User, error) {
	userData, ok := s.db.Get("session_" + session)
	if !ok {
		return nil, ErrSessionInvalid
	}
	user := userData.(domain.User)
	return &user, nil
}
