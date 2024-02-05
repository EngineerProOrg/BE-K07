package application

import "errors"

var (
	ErrUserNotFound   = errors.New("user not found")
	ErrDBInternal     = errors.New("internal server")
	ErrAuth           = errors.New("invalid pass or email")
	ErrSessionInvalid = errors.New("session invalid, try login again")
	ErrPing           = errors.New("try ping again later")
	ErrRateLimit      = errors.New("ping to much")
)
