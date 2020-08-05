#!/usr/bin/env groovy

// I see a lot of people do not define Pod Labels in configure Cloud settings in Jenkins
// They just define it as random label like below:
//                                               def podLabel = "worker-${UUID.randomUUID()}"

def call(String PodLabel, code) {
	podTemplate(
		cloud: 'kubernetes-cluster1',
		label: PodLabel,
		containers: [
			containerTemplate(
				name: 'ubuntu-image',
				image: 'ubuntu:bionic',
				command: 'cat',
				ttyEnabled: true)
		]) {
		code()
	}
}

// Applies in local jenkins
// @Library('general-jenkins-library@master') _
//
// PodTemplateUbuntu('pod-label-cluster1')
//     {
//         node('pod-label-cluster1') {
// 		    stage('Check Ubuntu Release') {
// 		        container('ubuntu-image') {
// 		            sh "cat /etc/*-release"
// 			}
// 		}
// 	}
// }
