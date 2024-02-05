package config

import "github.com/spf13/viper"

type Config struct {
	SQLHost     string `mapstructure:"SQL_HOST"`
	SQLUser     string `mapstructure:"SQL_User"`
	SQLPass     string `mapstructure:"SQL_PASSWORD"`
	SQLDatabase string `mapstructure:"SQL_DATABASE"`
	RedisUrl    string `mapstructure:"REDIS_URL"`

	ServerPort int `mapstructure:"SERVER_PORT"`
	SQLPort    int `mapstructure:"SQL_PORT"`
}

var _conf = Config{}

func LoadConfig(path string) (conf Config, err error) {
	viper.AddConfigPath(path)
	viper.SetConfigType("env")
	viper.SetConfigName("app")
	viper.AutomaticEnv()
	err = viper.ReadInConfig()
	if err != nil {
		return
	}
	viper.Unmarshal(&conf)
	_conf = conf
	return
}

func GetConfig() Config {
	return _conf
}
