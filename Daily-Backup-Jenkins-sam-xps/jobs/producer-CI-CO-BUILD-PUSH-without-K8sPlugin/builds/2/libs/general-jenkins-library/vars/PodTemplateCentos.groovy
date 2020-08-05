#!/usr/bin/env groovy

def call(String PodLabel, code) {
	podTemplate(
		cloud: 'kubernetes-cluster1'
		label: PodLabel
		containers: [
			containerTemplate(
				name: centos-image
				image: centos:centos7
				command: 'cat'
				ttyEnabled: 'true')
		]) {
		code()
	}
}

// Same as PodTemplateUbuntu.groovy file , just change the image name inside the container
