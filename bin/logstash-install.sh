#!/bin/bash


build_dir=$1
my_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

pushd $build_dir
  echo "Downloading and installing Logstash."
  wget -nv https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz
  tar xzf logstash-1.4.2.tar.gz
  mv logstash-1.4.2 logstash
  rm logstash-1.4.2.tar.gz
  pwd
  
  #echo "Copying customized server.xml file to Tomcat distribution"
  #cp $my_dir/../custom-server.xml .java-buildpack/tomcat/conf/server.xml 
popd

mkdir -p $build_dir/etc/logstash/conf.d
pushd $build_dir/etc/logstash/conf.d
  cat >"111-input.conf" <<EOF
input {
  file {
    path => '/home/vcap/app/.java-buildpack/tomcat/logs/**/*'
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
