#!/usr/bin/env bash
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
set -e

export POD_NAME=$(kubectl get pods --all-namespaces -o custom-columns=POD_NAME:.metadata.name | grep -i jenkins)
export POD_NS=$(kubectl get pods $POD_NAME -o jsonpath="{.metadata.namespace}")
export JENKINS_HOME=$(kubectl exec -i -t $POD_NAME -- printenv | grep "JENKINS_HOME" | cut -d= -f2 | tr -d '\r')
export datetime=$(date +%Y%m%d_%H:%M:%S)

backup_dir=Daily-Backup-Jenkins-sam-xps
rm -rf Daily-Backup-Jenkins-sam-xps
mkdir -p ${backup_dir} && cd $_

ORIGIFS=$IFS; IFS=$(echo -en "\n\b")
backup=(
"*.xml"
"jobs/*"
"nodes/*"
"plugins/*.jpi"
"secrets/*"
"users/*"
"userContent/*"
"ansible/*"
)

for line in "${backup[@]}"
do
  kubectl exec -i -n $POD_NS $POD_NAME -- /bin/sh -c "cd ${JENKINS_HOME} && tar cf - ${line}" | tar xf - -C .
done

cd ..

#optional compress the backup directory
#gzip -9 -r ${backup_dir}



#<< 'example' 
#Example for saving the backup in your private github repo
git_user=$(grep name ~/.gitconfig | cut -d= -f2 | sed 's/ //g')
git_pass=$(grep password ~/.gitconfig | cut -d= -f2 | sed 's/ //g')
git add ${backup_dir}
git commit -am "Daily Jenkins Backup Sync"
git push "https://${git_user}:${git_pass}@github.com/${git_user}/jenkins-backup.git"
#example
