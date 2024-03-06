# Prerequisites 
1. Install Docker Engine & CLI https://docs.docker.com/engine/install
2. Install golang-migrate CLI https://github.com/golang-migrate/migrate/tree/master/cmd/migrate
3. Install protoc and Go plugins https://grpc.io/docs/languages/go/quickstart/#prerequisites

# How to run the project from the scratch

## Initialize MySQL and Redis by Docker

Run `docker pull mysql` to pull `mysql` image to local

Rrom the root folder `/newfeed`:

Run to start MySQL instance 

`docker run --name ep-mysql -e MYSQL_ROOT_PASSWORD=123456 -e MYSQL_DATABASE=engineerpro -v ./mysql/my.cnf:/etc/mysql/my.cnf -v ./data/mysql:/var/lib/mysql -p 3306:330 -d mysql`

Run `make up_migration` to create tables

Run `docker pull redis`

Run to start Redis 

`docker run --name ep-redis -p 6379:6379 -d redis`

## Run gRPC server

Run `proto_aap` to generate `.pb.go` files from `.proto` files for Authen and Post service.

Run `go run cmd/authen_and_post_svc/main.go -conf configs/files/test.yml`

## Run HTTP server

Run `go run cmd/web_app/main.go -c configs/files/test.yml`