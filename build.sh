#!/usr/bin/env bash
PACKAGE="${PWD##*/}"
DOCKER_IMAGE=docker-reg.c.9rum.cc/cite/niko/test:latest

echo "### build package $PACKAGE"
docker run --rm \
  -v "$PWD":/usr/src/$PACKAGE \
  -w /usr/src/$PACKAGE \
  -e GOOS=linux \
  -e GOARCH=amd64 \
  -e CGO_ENABLED=0 \
  golang:1.6 \
  go build -v

echo "### build docker image $DOCKER_IMAGE"
docker build -t $DOCKER_IMAGE -f Dockerfile-alpine .

echo "### push docker image $DOCKER_IMAGE"
docker push $DOCKER_IMAGE
