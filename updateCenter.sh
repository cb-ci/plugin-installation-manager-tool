#! /bin/bash


curl -d "script=$(cat ./ucStoreAndPromoteWithDependencies.groovy)" \
  -v --user username:ApiToken https://jenkins.example.com/scriptText \
 pluginName=job-dsl updateCenterAction=STORE