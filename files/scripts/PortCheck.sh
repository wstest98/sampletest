#!/bin/sh

BASEDIR=$(dirname "$0")
. $BASEDIR/env.sh

unset JAVA_OPTS

PID=`ps -ef | grep java | grep "\[SERVER_NAME=${SERVER_NAME}\]" | awk '{print $2}'`

echo "###############################"
echo "## Service Listen Port Check ##"
echo "###############################"

netstat -anp 2>/dev/null | grep $PID | egrep "LISTEN|ESTABLISHED"

