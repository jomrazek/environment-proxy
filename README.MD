Create a Configmap from the custom Go template provided. This configuration will be mounted into the Pod and generated each time a new service is added.

```
oc create configmap customrouter --from-file=haproxy-config.template
```


Get the value of the environment namespace (OpenShift project) via the command `oc project` and use this in the placeholders in the following command:

```
sudo oc new-app -f router-template.json -n <environment-project-namespace> --param=ENVIRONMENT_NAMESPACE=<environment-project-namespace>
```
For example :

```
sudo oc new-app -f router-template.json -n rhmap-rhmap-myrouter --param=ENVIRONMENT_NAMESPACE=rhmap-rhmap-myrouter
```
