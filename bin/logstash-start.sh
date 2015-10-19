#!/bin/bash


ls -l /home/vcap/app/.java-buildpack/tomcat/conf
cat /home/vcap/app/.java-buildpack/tomcat/conf/server.xml

echo "Tomcat Log Files:"
ls -l /home/vcap/app/.java-buildpack/tomcat/logs

export JAVA_HOME="/home/vcap/app/.java-buildpack/open_jdk_jre"
/home/vcap/app/logstash/bin/logstash agent -f /home/vcap/app/etc/logstash/conf.d --debug &
