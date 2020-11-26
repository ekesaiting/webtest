#!/bin/sh
#setting project value
PRODUCT_CODE=webtest
MVC_CONFIG=com.feng.Application

#get project current path
PROJECT_PATH=`pwd`
pid=""

#get log path
LOG_DIR=$PROJECT_PATH/logs
mkdir -p $LOG_DIR

#get project pid
if [ -f $PROJECT_PATH/$PRODUCT_CODE.pid ]
then
	pid=`cat $PROJECT_PATH/$PRODUCT_CODE.pid`
fi

# if project is run,kill it
if [ "$pid" = "" ]
then
	echo "run ${PRODUCT_CODE}..."
else
	echo "${PRODUCT_CODE} is run, need kill "$pid
	kill -9 $pid
	sleep 1
	echo "kill $pid is success, reruning ${PRODUCT_CODE}..."
fi

# load project all jar file
for i in ../lib/*.jar;do
    LIB_PATH=${LIB_PATH}:$i
done

# setting opts
#512m
#export JAVA_OPTS="-Xmx320M -Xms320M -Xmn64M -XX:MaxMetaspaceSize=64M -XX:MetaspaceSize=64M -XX:+UseParallelGC -XX:+UseAdaptiveSizePolicy -XX:MaxGCPauseMillis=100 -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+HeapDumpOnOutOfMemoryError"
#1g
export JAVA_OPTS="-Xmx640M -Xms640M -Xmn192M -XX:MaxMetaspaceSize=128M -XX:MetaspaceSize=128M -XX:+UseParallelGC -XX:+UseAdaptiveSizePolicy -XX:MaxGCPauseMillis=100 -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+HeapDumpOnOutOfMemoryError"
#1.5g
#export JAVA_OPTS="-Xmx1024M -Xms1024M -Xmn384M -XX:MaxMetaspaceSize=192M -XX:MetaspaceSize=192M -XX:+UseParallelGC -XX:+UseAdaptiveSizePolicy -XX:MaxGCPauseMillis=100 -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+HeapDumpOnOutOfMemoryError"
#2g
#export JAVA_OPTS="-Xmx1344M -Xms1344M -Xmn448M -XX:MaxMetaspaceSize=256M -XX:MetaspaceSize=256M -XX:+UseConcMarkSweepGC -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=70 -XX:+ExplicitGCInvokesConcurrentAndUnloadsClasses -XX:+CMSClassUnloadingEnabled -XX:+ParallelRefProcEnabled -XX:+CMSScavengeBeforeRemark -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+HeapDumpOnOutOfMemoryError"

# run the project
#>$LOG_DIR/$PRODUCT_CODE.log
echo "The application will start in ${RUN_BEFORE_SLEEP}s..." && sleep ${RUN_BEFORE_SLEEP}
"$JAVA_HOME"/bin/java -Duser.timezone=GMT+8 -server $JAVA_OPTS -classpath $CLASSPATH:$LIB_PATH:$PROJECT_PATH $MVC_CONFIG > $LOG_DIR/$PRODUCT_CODE.log &
echo $! > $PRODUCT_CODE.pid
sleep 1
tail -f $LOG_DIR/$PRODUCT_CODE.log
