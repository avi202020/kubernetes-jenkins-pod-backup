Steps of the script:

1) Extracting jenkins pod name and namespace
You can modify your pod jenkins name , I assumed that the pod name starts with insensitive jenkins word 
NOTE: if you have jenkins cluster more than one pod then you can modify the POD_NAME var to be appropiate.

2) The script will grab all the neccessary backup files includes in "backup" array (you can add/modify the array)

3) since kubectl cp does not support wildcard, then kubernetes suggests the tar/untar model ,but it is not complete I modify it in order to make it happen.

The next step is will be how to restore your jenkins backup directory into the new jenkins pod .

