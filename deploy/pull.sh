#!/bin/sh

git pull origin main
docker-compose -f docker-compose-deploy.yml build web
docker-compose -f docker-compose-deploy.yml up --no-deps -d web