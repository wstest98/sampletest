#!/bin/sh
. ./env.sh

podman logs -f  ${CONTAINER_NAME}
