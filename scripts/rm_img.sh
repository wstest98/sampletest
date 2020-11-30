#!/bin/sh
. ./env.sh

podman rm ${CONTAINER_NAME}
sleep 1
podman rmi ${CONTAINER_NAME}:${VERSION}
