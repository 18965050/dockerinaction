#! /bin/bash
JAVA_OPTS=" -Djava.awt.headless=true -Djava.net.preferIPv4Stack=true -Ddubbo.shutdown.hook=true "
JAVA_MEM_OPTS=" -server -Xms1g -Xmx1g -Xmn256m -XX:PermSize=128m -Xss1m -XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:+UseCMSCompactAtFullCollection -XX:LargePageSizeInBytes=128m -XX:+UseFastAccessorMethods -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=70 "
JAVA_DEBUG_OPTS=" -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,address=2234,server=y,suspend=n "

LIB_DIR=./lib
LIB_JARS=`ls $LIB_DIR|grep .jar|awk '{print "'$LIB_DIR'/"$0}'|tr "\n" ":"` 

#STDOUT_FILE=/home/INS/logs/io-all/io-product-basic-stdout.log

#if [ -f $STDOUT_FILE ];then
        #        rm -rf $STDOUT_FILE
#fi

#touch $STDOUT_FILE

#nohup java ${JAVA_OPTS} ${JAVA_MEM_OPTS} ${JAVA_DEBUG_OPTS} -classpath ${LIB_JARS} cn.xyz.io.product.basic.Main > ${STDOUT_FILE} 2>&1
nohup java ${JAVA_OPTS} ${JAVA_MEM_OPTS} -classpath ${LIB_JARS} cn.xyz.io.product.basic.Main 2>&1