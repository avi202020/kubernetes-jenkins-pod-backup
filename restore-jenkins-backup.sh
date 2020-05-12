#!/usr/bin/env bash
set -e

#  The script will require an input variable where it is the backup directory created from the backup script
#  e.g = ./restore-jenkins-backup.sh jenkins_backup_dir_datetime

# Grabbing the new jenkins pod , I also assumed the same assumption in the first script :)
export POD_NAME=$(kubectl get pods --all-namespaces -o jsonpath="{.items[0].metadata.name}" | grep -i jenkins)
export POD_NS=$(kubectl get pods $POD_NAME -o jsonpath="{.metadata.namespace}")
export JENKINS_HOME=$(kubectl exec -i -t $POD_NAME -- printenv | grep "JENKINS_HOME" | cut -d= -f2 | tr -d '\r')

cd $1
tar cf - . | kubectl exec -i -n $POD_NS $POD_NAME -- tar xf - -C $JENKINS_HOME

#At last restart jenkins
