package cmd

import (
	"fmt"
	"learn-redis/config"
	"learn-redis/db"
	"log"
	"os"

	"github.com/spf13/cobra"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

var databaseCmd = &cobra.Command{
	Use:   "check_connect_sql",
	Short: "check mysql",
	Long:  "Check connect to database",
	Run: func(_ *cobra.Command, _ []string) {
		c := config.GetConfig()
		_, err := db.ConnectionToDB(c)
		if err != nil {
			log.Fatalln("connect data failed ", err)
			os.Exit(1)
		}
		log.Println("connected mysql")
		os.Exit(0)
	},
}

var redisCmd = &cobra.Command{
	Use:   "check_connect_redis",
	Short: "check redis",
	Long:  "Check connect to redis",
	Run: func(_ *cobra.Command, _ []string) {
		c := config.GetConfig()
		_, err := db.ConnectionRedis(c)
		if err != nil {
			log.Fatal("redis connect failed ", err)
			os.Exit(1)
		}
		log.Println("connected redis")
		os.Exit(0)
	},
}

var migrageGorm = &cobra.Command{
	Use:   "migrate_gorm",
	Short: "Gorm migrate gorm",
	Long:  `Save gorm auto migrate to file /db/migrate/{timestamp}.sql`,
	Run: func(_ *cobra.Command, _ []string) {
		conf := config.GetConfig()
		var _db *gorm.DB
		var err error
		_db, err = db.ConnectionToDB(conf)
		if err != nil {
			log.Fatal("db connected failed ", err)
			os.Exit(1)
		}
		_db.Logger.LogMode(logger.Info)
		sql := _db.Statement.SQL
		fmt.Println(sql)
	},
}
