package cmd

import (
	"fmt"
	"learn-redis/config"
	"learn-redis/db"
	"learn-redis/internal/auth"
	"log"
	"os"

	"github.com/gofiber/fiber/v2"
	"github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
	Use:   "app",
	Short: "Demo redis",
	Long:  "Demo redis with golang, fiber, gorm, mysql",
	Run: func(_ *cobra.Command, _ []string) {
		_db, err := db.ConnectionToDB(config.GetConfig())
		if err != nil {
			log.Fatal(err)
		}
		_rdb, err := db.ConnectionRedis(config.GetConfig())
		if err != nil {
			log.Fatal(err)
		}
		app := fiber.New()
		group := app.Group("/vi/api")
		auth.Router(group, _db, _rdb)
		addr := fmt.Sprintf(":%d", config.GetConfig().ServerPort)
		app.Listen(addr)
	},
}

func Execute() {
	rootCmd.AddCommand(databaseCmd)
	rootCmd.AddCommand(redisCmd)
	rootCmd.AddCommand(migrageGorm)
	if err := rootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}
