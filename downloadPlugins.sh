#! /bin/bash
DOWNLOAD_DIR=$(pwd)/plugins
CACHE_DIR=$(pwd)/.cache
CI_VERSION=2.277.2.3
mkdir -p $DOWNLOAD_DIR $CACHE_DIR
#cache PIMT jar
PIMT_JAR_CACHE_DIR=$CACHE_DIR/pimt-jar
if [[ -f $PIMT_JAR_CACHE_DIR/jenkins-plugin-manager.jar ]]; then
  echo "$PIMT_JAR_CACHE_DIR/jenkins-plugin-manager.jar already exist, remove it if you need to refresh" >&2
else
  mkdir -p $PIMT_JAR_CACHE_DIR
  curl -sLk https://github.com/jenkinsci/plugin-installation-manager-tool/releases/download/2.9.0/jenkins-plugin-manager-2.9.0.jar \
  -o $PIMT_JAR_CACHE_DIR/jenkins-plugin-manager.jar
fi


#download war
WAR_CACHE_DIR=$CACHE_DIR/war/$CI_VERSION
if [[ -f $WAR_CACHE_DIR/jenkins.war ]]; then
  echo "$WAR_CACHE_DIR/jenkins.war already exist, remove it if you need to refresh" >&2
else
  mkdir -p $WAR_CACHE_DIR
  curl -sLk https://downloads.cloudbees.com/cloudbees-core/traditional/client-master/rolling/war/$CI_VERSION/cloudbees-core-cm.war \
  -o $WAR_CACHE_DIR/jenkins.war
fi

#java -jar jenkins-plugin-manager-*.jar --war /your/path/to/jenkins.war --plugin-file /your/path/to/plugins.txt --plugins delivery-pipeline-plugin:1.3.2 deployit-plugin
#JENKINS_UC_HASH_FUNCTION="SHA1"

export JENKINS_UC_HASH_FUNCTION="SHA1"
export CACHE_DIR=$CACHE_DIR/jenkins-plugin-management-cli
#--jenkins-version 2.270
java -jar $PIMT_JAR_CACHE_DIR/jenkins-plugin-manager.jar --verbose \
    -d $DOWNLOAD_DIR \
    --war $WAR_CACHE_DIR/jenkins.war \
    --list \
    --plugin-file plugins.txt \
    --jenkins-update-center "https://jenkins-updates.cloudbees.com/update-center/core-mm/update-center.json"



