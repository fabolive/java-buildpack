#!/bin/bash

mkdir -p /home/vcap/app/opt
pushd /home/vcap/app/opt
  echo "Downloading and installing Logstash."
  wget -nv https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz
  tar xzf logstash-1.4.2.tar.gz
  mv logstash-1.4.2 logstash
  rm logstash-1.4.2.tar.gz
popd

mkdir -p /home/vcap/app/etc/logstash/conf.d
pushd app/etc/logstash/conf.d
  cat >"111-input.conf" <<EOF
input {
  file {
    path => '/var/log/messages'  
  }
}
EOF
popd

#my_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#JAVA_HOME="$my_dir/../.java-buildpack/open_jdk_jre"
#ls -la "$my_dir/.."
#ls -la /home/vcap
#app/opt/logstash/bin/logstash agent -f app/etc/logstash/conf.d &
