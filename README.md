Steps of the script:

A: Backup script

Extracting jenkins pod name and namespace You can modify your pod jenkins name , I assumed that the pod name starts with insensitive jenkins word NOTE: if you have jenkins cluster more than one pod then you can modify the POD_NAME var to be appropiate.

The script will grab all the neccessary backup files includes in "backup" array (you can add/modify the array)

since kubectl cp does not support wildcard, then kubernetes suggests the tar/untar model ,but it is not complete I modify it in order to make it happen.

The next step is will be how to restore your jenkins backup directory into the new jenkins pod .

B: Restore script

the script needs one input variable which is the backup directory created from previous section

after successful backup , you have to restart jenkins pod. To make restart : a) you can surf http://jenkins-url/restart and then apply restart b) if you have "minikube or persistentVolume" for example which does have persistentVolumeClaim then copy the files there, for minikube try it with ssh in directory /tmp/hostpath-provisioner file. c) you can restart the deployment by making "kubectl rollout restart deployment jenkins"

Last but not least : you can add a daily push to your github private/public repo.

To do so just uncomment the last lines and fill up your github credentials


C. Instal helm Jenkins with pre-defined PV & PVC (hostPath type Volume)


    Please apply the PV/PVC yaml files into your kubernetes cluster and then install the helm with the following flags directly from your cli :
    ~ helm install jenkins stable/jenkins --set persistence.enabled=true --set storageClass=jenkins-pv --set persistence.existingClaim=jenkins-pvc
    
    NOTE: the PV is a 10GB and the PVC will get all of the volume capacity to be unique for jenkins.
