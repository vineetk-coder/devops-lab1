#!/bin/bash
# Exercise 4 - Task 6: clean up
docker stop mysql redis flask && docker rm mysql redis flask
docker network rm my-bridge-net
