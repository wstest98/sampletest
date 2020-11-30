#!/bin/sh
. ./env.sh

podman ps |grep  ${CONTAINER_NAME}
