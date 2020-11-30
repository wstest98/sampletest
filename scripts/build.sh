#!/bin/sh
. ./env.sh

podman build -t ${REGISTRY}/${CONTAINER_NAME}:${VERSION} ../

sleep 1

podman run -d --name tomcat8_test -p 8580:8080 ${REGISTRY}/${CONTAINER_NAME}:${VERSION}
#podman run -d --name ${CONTAINER_NAME} -p 8180:8080 -v /storage/git_data/container_log/jws52/logs:/usr/local/jws-5.2/tomcat/logs ${REGISTRY}/${CONTAINER_NAME}:${VERSION}
#podman run -d --name ${CONTAINER_NAME} --log-driver=local -p 8580:8080 -v /test/DOCKER/podman-image/jws52/logs:/usr/local/jws-5.2/tomcat/logs ${CONTAINER_NAME}:${VERSION}
