#!/bin/bash
# Exercise 7 - Install Jenkins using Docker and obtain the initial admin password
set -e
if docker ps -a --format '{{.Names}}' | grep -qx jenkins; then
  echo "A 'jenkins' container already exists:"; docker ps -a --filter name=^jenkins$
  docker start jenkins >/dev/null
else
  docker run -d --name jenkins -p 8080:8080 -p 50000:50000 \
    -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts
fi
echo "Waiting for Jenkins to generate the initial admin password..."
for i in $(seq 1 60); do
  docker exec jenkins test -f /var/jenkins_home/secrets/initialAdminPassword && break
  sleep 3
done
echo -n "Initial admin password: "
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
echo "Open http://localhost:8080 -> paste password -> Install suggested plugins -> create admin user"
