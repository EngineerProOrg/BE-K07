package domain

import (
	"fmt"
	"time"

	"gorm.io/gorm"
)

const TableUser = "users"

type User struct {
	gorm.Model
	FirstName  string `gorm:"type:varchar(50);" json:"first_name"`
	LastName   string `gorm:"varchar(50);" json:"last_name"`
	Email      string `gorm:"type:varchar(50);unique;" json:"email"`
	Salt       string `gorm:"not null;" json:"-"`
	HashedPass string `gorm:"column:hashed_pass;not null;" json:"-"`
}

func (User) TableName() string {
	return TableUser
}

func NewUser(email, pass, firstName, lastName string) *User {
	salt := fmt.Sprintf("%d", time.Now().UnixMilli())

	return &User{
		FirstName:  firstName,
		LastName:   lastName,
		Email:      email,
		Salt:       salt,
		HashedPass: pass + salt,
	}
}

func (u User) VerifyPass(pass string) bool {
	return pass+u.Salt == u.HashedPass
}
