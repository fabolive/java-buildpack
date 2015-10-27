#!/bin/bash


build_dir=$1
my_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

LOGSTASH_CONF_DIR=$build_dir/etc/logstash/conf.d

mkdir -p $LOGSTASH_CONF_DIR

cp $my_dir/logstash*.sh $build_dir

pushd $build_dir
  echo "Downloading and installing Logstash"
  wget -nv https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz
  tar xzf logstash-1.4.2.tar.gz
  mv logstash-1.4.2 logstash
  rm logstash-1.4.2.tar.gz
  echo "Copying customized server.xml file to Tomcat distribution"
  cp $my_dir/../logstash-related-config/custom-server.xml .java-buildpack/tomcat/conf/server.xml

  echo "Unpacking and configuring collectd"
  tar xzf $my_dir/../collectd.tgz
  rm $my_dir/../collectd.tgz
  cp $my_dir/../logstash-related-config/collectd.template etc/collectd.conf
popd

echo "Generating Logstash configuration"
cp $my_dir/../logstash-related-config/logstash-tomcat.template $LOGSTASH_CONF_DIR/logstash-tomcat.conf
sed -i s"/TOMCAT_SERVER_DIR/\/home\/vcap\/app\/\.java-buildpack\/tomcat/" $LOGSTASH_CONF_DIR/logstash-tomcat.conf
sed -i s"/CA_TAG/$CA_TAG/" $LOGSTASH_CONF_DIR/logstash-tomcat.conf
sed -i s"/ES_HOST/$ES_HOST/" $LOGSTASH_CONF_DIR/logstash-tomcat.conf
sed -i s"/ES_PORT/$ES_PORT/" $LOGSTASH_CONF_DIR/logstash-tomcat.conf
sed -i s"/INDEX/$ES_INDEX/" $LOGSTASH_CONF_DIR/logstash-tomcat.conf

cat $LOGSTASH_CONF_DIR/logstash-tomcat.conf

