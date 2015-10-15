#!/bin/bash

mkdir -p /home/vcap/app/etc/logstash/conf.d
pushd /home/vcap/app/etc/logstash/conf.d
  cat >"111-input.conf" <<EOF
input {
  file {
    path => '/var/log/messages'  
  }
}
EOF
popd

JAVA_HOME="/home/vcap/app/.java-buildpack/open_jdk_jre"
/home/vcap/app/opt/logstash/bin/logstash agent -f /home/vcap/app/etc/logstash/conf.d &
