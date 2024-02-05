package db

import (
	"fmt"
	"learn-redis/config"
	"log"

	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

func ConnectionToDB(conf config.Config) (*gorm.DB, error) {
	dsn := fmt.Sprintf("%s:%s@tcp(%s:%d)/%s?charset=utf8mb4&parseTime=True&loc=Local",
		conf.SQLUser, conf.SQLPass, conf.SQLHost, conf.SQLPort, conf.SQLDatabase)
	db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatal("Connect to mysql database failed:", err)
	}
	return db, err
}
