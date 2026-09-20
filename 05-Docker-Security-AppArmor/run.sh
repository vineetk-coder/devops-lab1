#!/bin/bash
# Exercise 5 - full run on an AppArmor-enabled Linux host (Ubuntu/Debian)
set -e
aa-enabled || { echo "AppArmor is not enabled on this host"; exit 1; }
sudo apt-get install -y apparmor-utils
sudo cp my-apparmor-profile /etc/apparmor.d/my-apparmor-profile
sudo apparmor_parser -r /etc/apparmor.d/my-apparmor-profile
sudo aa-status | grep my-apparmor-profile

docker build -t flask-apparmor .

# CLI variant (Task 3c)
docker run -d --name flask-aa --security-opt="apparmor=my-apparmor-profile" -p 5000:5000 flask-apparmor
sleep 3
curl -s http://localhost:5000; echo
docker inspect -f '{{.AppArmorProfile}}' flask-aa
docker exec flask-aa cat /etc/passwd && echo "UNEXPECTED: read allowed" || echo "BLOCKED: cat /etc/passwd (exit $?)"
docker exec flask-aa /bin/bash -c true && echo "UNEXPECTED: bash allowed" || echo "BLOCKED: /bin/bash (exit $?)"
docker rm -f flask-aa

# SDK variants (Task 4 and 5)
python3 -m pip install -r requirements.txt
python3 apply_apparmor.py
python3 test_restricted_actions.py
sudo dmesg | grep 'apparmor="DENIED"' | grep my-apparmor-profile | tail -n 5 || true
