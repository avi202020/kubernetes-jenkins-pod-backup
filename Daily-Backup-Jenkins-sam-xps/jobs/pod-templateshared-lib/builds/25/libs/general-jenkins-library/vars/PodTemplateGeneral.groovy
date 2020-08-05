#!/usr/bin/env groovy

def call(Map podParams, code) {
	podTemplate(
		cloud: podParams.cloud,
		label: podParams.label,
		containers: [
			containerTemplate(
				name: podParams.name,
				image: podParams.image,
				command: 'cat',
				ttyEnabled: 'true')
		]) {
		code()
	}
}


// Apply Locally in Jenkins and change per your configuration in cloud settings in Jenkins
// @Library('general-jenkins-library@master') _
//
// PodTemplateGeneral(cloud: 'kubernetes-Cluster2', label:'general-pod-label-cluster2', name: 'maven-image', image: 'maven:3.3.9-jdk-8-alpine')
//     {
//         node('general-pod-label-cluster2') {
// 		    stage('Check Maven Release') {
// 		        container('maven-image') {
// 		            sh "cat /etc/*-release"
// 			}
// 		}
// 	}
// }


