#!/bin/bash

my_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


mkdir -p /home/vcap/app/opt
cp $my_dir/logstash*.sh /home/vcap/app

pushd /home/vcap/app/opt
  echo "Downloading and installing Logstash."
  wget -nv https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz
  tar xzf logstash-1.4.2.tar.gz
  mv logstash-1.4.2 logstash
  rm logstash-1.4.2.tar.gz
popd
