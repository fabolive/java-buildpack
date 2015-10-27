#!/bin/bash


ls -l /home/vcap/app/.java-buildpack/tomcat/conf
cat /home/vcap/app/.java-buildpack/tomcat/conf/server.xml

echo "Tomcat Log Files:"
ls -l /home/vcap/app/.java-buildpack/tomcat/logs
echo "/home/vcap/app"
ls -l /home/vcap/app
echo "/home/vcap"
ls -l /home/vcap

/home/vcap/app/collectd/sbin/collectd -C /home/vcap/app/etc/collectd.conf

export JAVA_HOME="/home/vcap/app/.java-buildpack/open_jdk_jre"
export LS_HEAP_SIZE=256m
/home/vcap/app/logstash/bin/logstash agent -f /home/vcap/app/etc/logstash/conf.d &
