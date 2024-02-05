package main

import (
	"fmt"
	"learn-redis/cmd"
	"learn-redis/config"
	"os"
	"os/signal"
	"syscall"
)

func main() {
	fmt.Println("Start app")
	exit := make(chan os.Signal, 1)
	signal.Notify(exit, os.Interrupt, syscall.SIGTERM)
	go func() {
		<-exit
		fmt.Println("Exit app")
		os.Exit(0)
	}()
	config.LoadConfig(".")
	cmd.Execute()
}
