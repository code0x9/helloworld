#!/usr/bin/env bash
DOCKER_IMAGE=cite-docker-reg.c.9rum.cc/test:latest
VULCAND_EP=http://vulcand.c.9rum.cc:8182
ETCD_EP=http://etcd.c.9rum.cc:2379
export CONTAINER_NAME=helloworld
DESIRED=2

vulcand() {
  CMD=$(echo $2 | envsubst)
  echo curl -X POST -s -H "Content-Type: application/json" ${VULCAND_EP}/$1 -d "$CMD"
  curl -X POST -s -H "Content-Type: application/json" ${VULCAND_EP}/$1 -d "$CMD"
  echo
}

echo "### build docker image ${DOCKER_IMAGE}"
docker build -t ${DOCKER_IMAGE} .

echo "### publish docker image ${DOCKER_IMAGE}"
docker push ${DOCKER_IMAGE}

### use docker-swarm
DOCKER_HOST=tcp://cite-node.c.9rum.cc:2376
unset DOCKER_TLS_VERIFY

echo "### scale to desired"
docker-compose scale web=${DESIRED}

echo "### pull new version"
docker-compose pull

OLD_CONTAINERS=$(docker ps -a --filter "name=${CONTAINER_NAME}" --filter 'status=running' --format {{.ID}})

echo "### scale up to desired * 2"
docker-compose scale web=$((DESIRED * 2))

echo "### killing old containers"
for CONTAINER in $OLD_CONTAINERS; do
    docker stop $CONTAINER
done

echo "### update vulcand servers"
curl -XDELETE "${ETCD_EP}/v2/keys/vulcand/backends/${CONTAINER_NAME}/?dir=true&recursive=true"

vulcand v2/backends '{"Backend": {"Id":"${CONTAINER_NAME}", "Type":"http"}}'
vulcand v2/frontends '{"Frontend": {"Id":"${CONTAINER_NAME}", "Type": "http", "BackendId": "${CONTAINER_NAME}", "Route": "HostRegexp(\"^${CONTAINER_NAME}..*\")"}}'

export svr_idx=1
PORTS=$(docker ps -a --filter "name=${CONTAINER_NAME}" --filter "status=running" --format {{.Ports}} | cut -d '-' -f 1)
for PORT in $PORTS; do
    export PORT
    vulcand v2/backends/${CONTAINER_NAME}/servers '{"Server": {"Id":"srv${svr_idx}", "URL":"http://${PORT}"}}'
    let "svr_idx += 1"
done
