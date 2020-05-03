Steps of the script:

A: Backup script

1) Extracting jenkins pod name and namespace
You can modify your pod jenkins name , I assumed that the pod name starts with insensitive jenkins word 
NOTE: if you have jenkins cluster more than one pod then you can modify the POD_NAME var to be appropiate.

2) The script will grab all the neccessary backup files includes in "backup" array (you can add/modify the array)

3) since kubectl cp does not support wildcard, then kubernetes suggests the tar/untar model ,but it is not complete I modify it in order to make it happen.

The next step is will be how to restore your jenkins backup directory into the new jenkins pod .


B: Restore script

1) the script needs one input variable which is the backup directory created from previous section

2) after successful backup , you have to restart jenkins pod.
To make restart : 
  a) you can surf http://jenkins-url/restart and then apply restart
  b) if you have "minikube or persistentVolume" for example which does have persistentVolumeClaim then copy the files there, for minikube try it with ssh in directory /tmp/hostpath-provisioner file.
  c) you can restart the deployment by making "kubectl rollout restart deployment jenkins"

