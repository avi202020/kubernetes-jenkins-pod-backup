#!/usr/bin/env groovy

def call(Map gitcoParams) {
    checkout([
        $class: 'GitSCM',
        branches: [[name:  gitcoParams.branch ]],
        userRemoteConfigs: [[ url: gitcoParams.url ]]
    ])
  }