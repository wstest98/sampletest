#!/bin/sh
. ./env.sh

podman exec -it ${CONTAINER_NAME} /bin/bash
