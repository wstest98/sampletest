#!/bin/sh
. ./env.sh

podman images | head -n 1
podman images |grep "${CONTAINER_NAME}"
