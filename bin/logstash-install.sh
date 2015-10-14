#!/bin/bash

mkdir -p app/opt
pushd app/opt
  echo "Downloading and installing Logstash."
  wget -nv https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz
  tar xzf logstash-1.4.2.tar.gz
  mv logstash-1.4.2 logstash
  rm logstash-1.4.2.tar.gz
popd

mkdir -p app/etc/logstash/conf.d
pushd app/etc/logstash/conf.d
  cat >"111-input.conf" <<EOF
input {
  file {
    path => '/var/log/messages'  
  }
}
EOF
popd

app/opt/logstash/bin/logstash agent -f app/etc/logstash/conf.d &
