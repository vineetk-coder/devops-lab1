#!/bin/bash
# Exercise 4 - Docker networking with Flask + MySQL + Redis (run from this directory)
set -e

echo "== Task 1-3: create / list / inspect bridge network =="
docker network create --driver bridge my-bridge-net
docker network ls
docker network inspect my-bridge-net

echo "== Task 4: build and launch containers =="
docker build -t flask-api .
docker run -d --name mysql --net=my-bridge-net -e MYSQL_ROOT_PASSWORD=rootpass mysql:latest
docker run -d --name redis --net=my-bridge-net redis:latest
docker run -d --name flask --net=my-bridge-net -p 5001:5001 \
  -e MYSQL_HOST=mysql -e MYSQL_PASSWORD=rootpass -e REDIS_HOST=redis flask-api
docker ps

echo "Waiting for MySQL to accept connections..."
for i in $(seq 1 60); do
  docker exec mysql mysqladmin ping -uroot -prootpass --silent 2>/dev/null && break
  sleep 2
done

echo "== Containers attached to my-bridge-net =="
docker network inspect my-bridge-net --format '{{range .Containers}}{{.Name}} {{.IPv4Address}}{{"\n"}}{{end}}'

echo "== Task 5: connectivity via container names =="
docker exec flask ping -c 2 mysql
docker exec flask ping -c 2 redis

echo "== Application tests =="
sleep 2
curl -s http://localhost:5001/about; echo
curl -s http://localhost:5001/redis; echo
curl -s http://localhost:5001/mysql; echo

docker logs flask | tail -n 20
echo "Run ./cleanup.sh to remove containers and network (Task 6)."
