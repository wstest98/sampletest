#!/bin/sh

##### DEFAULT ENV  #####
export ROCK_SERVER_USER=ROCK_SERVER_USER
export ROCK_JWS_VERSION=ROCK_JWS_VERSION
export ROCK_SERVER_HOME=ROCK_SERVER_HOME
export ROCK_SERVER_NAME=ROCK_SERVER_NAME
export ROCK_LOG_HOME=ROCK_LOG_HOME
export ROCK_PORT_OFFSET=ROCK_PORT_OFFSET
export ROCK_HEAP_MAX=ROCK_HEAP_MAX
export ROCK_HEAP_MIN=ROCK_HEAP_MIN
export ROCK_META_MAX=ROCK_META_MAX
export ROCK_META_MIN=ROCK_META_MIN

##### NEW ENV Setup #####
export SERVER_USER=jboss
export JWS_VERSION="jws-5.2"
export FULL_PATH=$(cd  "$(dirname "$0")" %&& pwd)
export SERVER_HOME=`echo $FULL_PATH|rev|cut -d '/' -f 4-|rev`    
export SERVER_NAME=`echo $FULL_PATH|rev|cut -d '/' -f 2|rev`       
export LOG_HOME=${CATALINA_BASE}/logs
export PORT_OFFSET=100
export HEAP_MAX=Xmx1024m
export HEAP_MIN=Xms1024m
export META_MAX=256m
export META_MIN=256m

##### create env.sh ######
env_create()
{
cp jws_env.sh ./env.sh
chmod 700 ./env.sh
}

##### setup env.sh ######
env_setup()
{
sed -i "s/${ROCK_SERVER_USER}/${SERVER_USER}/g" ./env.sh
sed -i "s/${ROCK_JWS_VERSION}/${JWS_VERSION}/g" ./env.sh
sed -i "s/${ROCK_SERVER_HOME}/${SERVER_HOME//\//\\/}/g" ./env.sh
sed -i "s/${ROCK_SERVER_NAME}/${SERVER_NAME}/g" ./env.sh
sed -i "s/${ROCK_LOG_HOME}/${LOG_HOME//\//\\/}/g" ./env.sh
sed -i "s/${ROCK_PORT_OFFSET}/${PORT_OFFSET}/g" ./env.sh
sed -i "s/${ROCK_HEAP_MAX}/${HEAP_MAX}/g" ./env.sh
sed -i "s/${ROCK_HEAP_MIN}/${HEAP_MIN}/g" ./env.sh
sed -i "s/${ROCK_META_MAX}/${META_MAX}/g" ./env.sh
sed -i "s/${ROCK_META_MIN}/${META_MIN}/g" ./env.sh
}

log_dir_create()
{
mkdir -p $LOG_HOME
}

env_create
env_setup
#log_dir_create

