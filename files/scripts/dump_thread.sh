#!/usr/bin/env bash

BASEDIR=$(dirname "$0")
. $BASEDIR/env.sh

unset JAVA_OPTS

PID=`ps -ef | grep java | grep "\[SERVER_NAME=${SERVER_NAME}\]" | awk {'print $2'}`

COUNT="1 2 3" 
TOP_CPU_LOG_FILE=$LOG_HOME/${SERVER_NAME}_top_cpu.log
THREAD_DUMP_FILE=$LOG_HOME/${SERVER_NAME}_thread_dump.log

if [ "$PID" = "" ]
then
  echo "ERROR: no such process : PID does not exist."
  exit 1
fi

echo "Target Process Number is : [$PID]"

for count in $COUNT; do
  echo "Thread Dump count : $count"
  echo "Sending signal...and wait 3 sec $PID"
  DATE_C1=`date +%Y%m%d_%H%M%S`
  jstack -l $PID  > $THREAD_DUMP_FILE.$DATE_C1
  echo "Logging CPU Utilization per Thread..."
  top -H -c -b -n1 > $TOP_CPU_LOG_FILE.$DATE_C1
  sleep 3
done
echo "See the following files..."
echo "-- $LOG_HOME/nohup/thread_dump.log[yyyy-mm-dd_HHMMSS] -- for Thread Dump"
echo "-- $LOG_HOME/top_cpu_log.[yyyy-mm-dd_HHMMSS] -- for Top CPU Utilization Thread."

