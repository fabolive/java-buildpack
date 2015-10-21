#!/bin/bash


build_dir=$1
my_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

LOGSTASH_CONF_DIR=$build_dir/etc/logstash/conf.d

cp $my_dir/logstash*.sh $build_dir

pushd $build_dir
  echo "Downloading and installing Logstash."
  wget -nv https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz
  tar xzf logstash-1.4.2.tar.gz
  mv logstash-1.4.2 logstash
  rm logstash-1.4.2.tar.gz
  pwd
  cat /etc/issue
  uname -a
  echo "Testing logrotate..."
  $my_dir/logrotate
  
  echo "Copying customized server.xml file to Tomcat distribution"
  cp $my_dir/../logstash-related-config/custom-server.xml .java-buildpack/tomcat/conf/server.xml 
popd

echo "Generating Logstash configuration"
mkdir -p $LOGSTASH_CONF_DIR
cp $my_dir/../logstash-related-config/logstash-tomcat.template $LOGSTASH_CONF_DIR/logstash-tomcat.conf
sed -i s"/TOMCAT_SERVER_DIR/\/home\/vcap\/app\/\.java-buildpack\/tomcat/" $LOGSTASH_CONF_DIR/logstash-tomcat.conf
sed -i s"/CA_TAG/$CA_TAG/" $LOGSTASH_CONF_DIR/logstash-tomcat.conf
sed -i s"/ES_HOST/$ES_HOST/" $LOGSTASH_CONF_DIR/logstash-tomcat.conf
sed -i s"/ES_PORT/$ES_PORT/" $LOGSTASH_CONF_DIR/logstash-tomcat.conf
sed -i s"/INDEX/$ES_INDEX/" $LOGSTASH_CONF_DIR/logstash-tomcat.conf

cat $LOGSTASH_CONF_DIR/logstash-tomcat.conf
