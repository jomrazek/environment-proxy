Update the parameters in router-template.json to match the ServiceAccount and Namespace in the current OpenShift project.

Run the following command to grant permissions to the user, replacing with same values:

`sudo oadm policy add-cluster-role-to-user cluster-reader system:serviceaccount:${ENVIRONMENT_NAMESPACE}:${ENVIRONMENT_USER}`


sudo oadm policy add-cluster-role-to-user cluster-reader system:serviceaccount:rhmap-rhmap-haproxy:rhmap-user-haproxy
