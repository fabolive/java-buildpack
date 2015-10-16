#!/bin/bash


export JAVA_HOME="/home/vcap/app/.java-buildpack/open_jdk_jre"
/home/vcap/app/logstash/bin/logstash agent -f /home/vcap/app/etc/logstash/conf.d &
