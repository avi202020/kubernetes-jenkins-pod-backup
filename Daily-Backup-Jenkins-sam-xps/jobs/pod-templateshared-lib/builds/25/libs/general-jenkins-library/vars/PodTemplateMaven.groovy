#!/usr/bin/env groovy

def call(String PodLabel, code) {
	podTemplate(
		cloud: 'kubernetes-Cluster2',
		label: PodLabel,
		containers: [
			containerTemplate(
				name: maven-image,
				image: maven:3.3.9-jdk-8-alpine,
				command: 'cat',
				ttyEnabled: 'true')
		]) {
		code()
	}
}

// Same as PodTemplateUbuntu.groovy file , just change the image name inside the container


// Maven git + mvn clean install with Jenkins Library PodTemplateGeneral :
// @Library('general-jenkins-library@master') _
//
// PodTemplateGeneral(
//     cloud: 'kubernetes-Cluster2',
//     label:'general-pod-label-cluster2',
//     name: 'maven-image',
//     image: 'maven:3.3.9-jdk-8-alpine')
//     {
//         node('general-pod-label-cluster2') {
// 		    stage('Check Maven Release') {
// 		        container('maven-image') {
// 		            gitCo(
// 						branch: "master",
//                         url: "https://github.com/web3j/sample-project-maven"
//                         )}
// 		    }
// 		    stage('Install mvn') {
// 		        container('maven-image') {
// 		            sh 'mvn clean install'
// 		        }
// 		    }
// 		}
// 	}



