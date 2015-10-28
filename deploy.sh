#!/usr/bin/env bash
command -v fleet-restart.sh >/dev/null 2>&1 || { echo >&2 "fleet-restart.sh not found on PATH. please link https://github.daumkakao.com/CTF/kubernetes-ansible/blob/daumkakao/misc/fleet-restart.sh to your PATH."; exit 1; }

## check prerequisites
DOCKER_IMAGE=cite-docker-reg.c.9rum.cc/niko/helloworld:latest
CONTAINER_NAME=$(basename $(pwd))

echo "### build docker image ${DOCKER_IMAGE}"
docker build -t ${DOCKER_IMAGE} .

echo "### publish docker image ${DOCKER_IMAGE}"
docker push ${DOCKER_IMAGE}

source fleet-restart.sh ${CONTAINER_NAME}
