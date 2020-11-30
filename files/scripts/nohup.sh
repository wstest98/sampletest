#!/usr/bin/env bash

BASEDIR=$(dirname "$0")
. $BASEDIR/env.sh > /dev/null

unset JAVA_OPTS
 
tail -f ${LOG_HOME}/nohup/${SERVER_NAME}.out
