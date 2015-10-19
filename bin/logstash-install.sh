#!/bin/bash


build_dir=$1
my_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cp $my_dir/logstash*.sh $build_dir

pushd $build_dir
  echo "Downloading and installing Logstash."
  wget -nv https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz
  tar xzf logstash-1.4.2.tar.gz
  mv logstash-1.4.2 logstash
  rm logstash-1.4.2.tar.gz
popd

ls -l

mkdir -p $build_dir/etc/logstash/conf.d
pushd $build_dir/etc/logstash/conf.d
  cat >"111-input.conf" <<EOF
input {
  file {
    path => '/var/log/messages'  
  }
}
EOF


  cat >"900-output.conf" <<EOF
output {
  stdout {
  }
}
EOF
popd

if [ -z "$TEST_VAR" ]; then
  echo "YYYYYYYYYYYYYYYYYYYYYYYYYYes"
else
  echo "NNNNNNNNNNNNNNNNNNNNNNNNNNNo"
fi
