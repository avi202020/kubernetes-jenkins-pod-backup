#!/usr/bin/env bash
export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
set -e

export POD_NAME=$(kubectl get pods --all-namespaces -o jsonpath="{.items[0].metadata.name}" | grep -i jenkins)
export POD_NS=$(kubectl get pods $POD_NAME -o jsonpath="{.metadata.namespace}")
export JENKINS_HOME=$(kubectl exec -i -t $POD_NAME -- printenv | grep "JENKINS_HOME" | cut -d= -f2 | tr -d '\r')
export datetime=$(date +%Y%m%d_%H:%M:%S)

backup_dir=jenkins_backup_$datetime
mkdir -p $backup_dir && cd $_

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

#Optional : You can add to push directly to you github :
#git add .
#git commit -am "Daily Jenkins Backup Sync"
#gzip -9 $backup_dir
#git push "https://${git_user}:${git_pass}@github.com/${git_user}/repo.git"

