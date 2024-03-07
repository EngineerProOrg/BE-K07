# Prerequisites 
1. Install Docker Engine & CLI https://docs.docker.com/engine/install
2. Install golang-migrate CLI https://github.com/golang-migrate/migrate/tree/master/cmd/migrate
3. Install protoc and Go plugins https://grpc.io/docs/languages/go/quickstart/#prerequisites

# How to run the project from the scratch

## 1. Initialize MySQL and Redis by Docker

### 1.1. Init MySQL
Pull the `mysql` image from Docker Hub to local

    docker pull mysql

From the root folder `/newfeed`:

Run to start MySQL instance. This command run a Docker container named `ep-mysql` based on the image we just pulled, with enviroment variables `MYSQL_ROOT_PASSWORD=123456`, `MYSQL_DATABASE=engineerpro`, config file `./mysql/my.cnf`, and use `./data/mysql` to persist data on host disk (to make sure data is not lost even the container stops).  

    docker run --name ep-mysql -e MYSQL_ROOT_PASSWORD=123456 -e MYSQL_DATABASE=engineerpro -v ./mysql/my.cnf:/etc/mysql/my.cnf -v ./data/mysql:/var/lib/mysql -p 3306:330 -d mysql

To check if the MySQL container is ready, we connect and run command shell in the container to check (open a new terminal, we name it `check` terminal):

    docker exec -it ep-mysql /bin/bash

If the container is ready, it will connect and display the container shell, continue to check if the `engineerpro` database is created:

    bash# mysql -p engineerpro
    Enter password: 123456

    mysql > show databases;
    +--------------------+
    | Database           |
    +--------------------+
    | engineerpro        |
    | information_schema |
    | mysql              |
    | performance_schema |
    | sys                |
    +--------------------+
    5 rows in set (0.01 sec)

Back to the terminal at the `newsfeed` folder , Run data migration script to create tables. To see the details what this command does, check the `Makefile` file.

    make up_migration

Back to use the `check` terminal above (which we run `docker exec`) to see our tables are created.

    mysql> show tables;
    +-----------------------+
    | Tables_in_engineerpro |
    +-----------------------+
    | comment               |
    | following             |
    | like                  |
    | post                  |
    | schema_migrations     |
    | user                  |
    +-----------------------+
    6 rows in set (0.00 sec)

### 1.2. Init MySQL

    docker pull redis

Run to start Redis 

    docker run --name ep-redis -p 6379:6379 -d redis

Use `redis-cli` to connect the container to verify if Redis is ready. (Install `redis-cli` here, it is usually installed along with the Redis server https://redis.io/docs/install/install-redis/)

    redis-cli -h localhost -p 6379
    
    127.0.0.1:6379> ping
    PONG

## 2. Run gRPC server
Run Auth and Post gRPC server with config file.

    go run cmd/authen_and_post_svc/main.go -c configs/files/test.yml

    2024/03/07 18:53:46 starts with config: {Port:19001 MySQL:{DriverName: ServerVersion: DSN:root:123456@tcp(localhost:3306)/engineerpro?charset=utf8mb4&parseTime=True&loc=Local DSNConfig:<nil> Conn:<nil> SkipInitializeWithVersion:false DefaultStringSize:256 DefaultDatetimePrecision:<nil> DisableWithReturning:false DisableDatetimePrecision:true DontSupportRenameIndex:true DontSupportRenameColumn:false DontSupportForShareClause:false DontSupportNullAsDefaultValue:false DontSupportRenameColumnUnique:false} Redis:{Network: Addr:localhost:6379 Dialer:<nil> OnConnect:<nil> Username: Password: DB:0 MaxRetries:0 MinRetryBackoff:0s MaxRetryBackoff:0s DialTimeout:0s ReadTimeout:0s WriteTimeout:0s PoolFIFO:false PoolSize:0 MinIdleConns:0 MaxConnAge:0s PoolTimeout:0s IdleTimeout:0s IdleCheckFrequency:0s readOnly:false TLSConfig:<nil> Limiter:<nil>}}
    2024/03/07 18:53:47 grpc server starting on 0.0.0.0:19001

 This gRPC process all business logic related Auth and Post, and communicates directly with database.

## 3. Run HTTP server

Run the Webapp HTTP server.

    go run cmd/web_app/main.go -c configs/files/test.yml

    2024/03/07 18:55:28 parsed config: {Port:19003 AuthenticateAndPost:{Hosts:[localhost:19001]} Newsfeed:{Hosts:[]}}
    [GIN-debug] ...
    ...
    [GIN-debug] Listening and serving HTTP on :19003
    

This HTTP server serves HTTP request, then get the response from the gRPC server above to return API response. 

# Some tech stack detail

## 1. Databse

### 1.1. GORM 

https://gorm.io/docs/index.html

- How to map models from the database schema. See `/internal/pkg/types/db_model.go`
- How to do simple queries: create/select by id/update/delete. See `/internal/app/authen_and_post_svc/user_handler.go`
- How to deal with associations, like user-post ..

### 1.2. Golang-migrate

https://github.com/golang-migrate/migrate/tree/master/cmd/migrate#usage
https://www.freecodecamp.org/news/database-migration-golang-migrate/

Check `new_migration, up_migration, down_migration` in the `Makefile`

## 2. Gin

## 3. gRPC
gRPC is a protocol use protobuf data structure (like HTTP use JSON data)

Guide to build a simple grpc server/client: https://grpc.io/docs/languages/go/quickstart/

Step to build a gRPC server/client:
1. Create `.proto` files, which defines the service and the commands with input/output.
2. Use `protoc` to generate `pb.go` and `grpc.pb.go` files.
   1. `*pb.go` includes the struct of message (input/output)
   2. `*grpc.pb.go` includes gRPC server/client interfaces
3. Implement the server, which implements the generated server interface. See `AuthenticateAndPostServer` in `internal/app/authen_and_post_svc/server.go`
4. Use the client implementation in the `grpc.pb.go` file to call to server. See `NewClient` in `pkg/client/authen_and_post/client.go`

The command to generate `.pb.go` files from `.proto` files for Authen and Post service.

    make proto_aap

    or 

    protoc --proto_path=pkg/types/proto/ --go_out=pkg/types/proto/pb/authen_and_post --go_opt=paths=source_relative \
        --go-grpc_out=pkg/types/proto/pb/authen_and_post --go-grpc_opt=paths=source_relative \
        authen_and_post.proto

`--proto_path` defines the `.proto` file location

`--go_out` defines the gen `pb.go` files destination

`--go-grpc_out` defines the gen `grpc.pb.go` files destination (which contains gRPC server/client generated code)

https://protobuf.dev/reference/go/go-generated/

