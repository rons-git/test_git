#!/bin/bash
tput setaf 3 && echo Remove All Images and Containers && tput setaf 252 && set -x
# Remove all Docker containers
docker rm -f $(docker ps -aq) &> /dev/null
# Remove all Docker images
docker rmi $(docker images -q) &> /dev/null
# Remove all unused Docker containers, networks, and images (both dangling and unused).
docker system prune -af --volumes &> /dev/null
docker volume rm $(docker volume ls -qf dangling=true) &> /dev/null
# Remove all named volumes
docker compose down -v &> /dev/null
