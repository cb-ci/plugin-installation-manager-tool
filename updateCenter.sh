#! /bin/bash


curl -d "script=$(cat /tmp/system-message-example.groovy)" \
  -v --user username:ApiToken https://jenkins.example.com/scriptText \
 pluginName=job-dsl updateCenterAction=STORE