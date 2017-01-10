# RHMAP Environment Proxy

This project enables the use of Non-SSL Wildcard certificates when running RHMAP on the OpenShift Container Platform. It deploys a custom OpenShift router inside a RHMAP Environment Project, which works as a proxy to forward requests to the applications and services running within that environment.

## Usage

When there is a specific requirement which disallows the use of wildcard certificates, this application should be deployed inside the per-environment project, created by RHMAP on OpenShift when an environment is created via the studio. The template will create a deployment configuration and service called `environment-proxy` in the OpenShift project. A route will also be created which must be configured with an SSL certifcate by the end user.

Once applications are deployed to this environment, the environment-proxy application will learn about them automatically, and they will be reachable via the proxy. This negates the need for an SSL certificate to be placed on each applications route.

## Installation

This application relies on the creation of a ConfigMap object. Create this Configmap from the custom Golang template provided, using the following command:

```
oc create configmap customrouter --from-file=haproxy-config.template
```


Get the value of the environment namespace (RHMAP environment project in OpenShift) via the command `oc get projects`. This should take the format `rhmap-rhmap-myEnvironmentName` and use this in the placeholders in the following command, which must be run as administrator:

```
sudo oc new-app -f router-template.json -n <environment-project-namespace> --param=ENVIRONMENT_NAMESPACE=<environment-project-namespace>
```

For example :

```
sudo oc new-app -f router-template.json -n rhmap-rhmap-myEnvironmentName --param=ENVIRONMENT_NAMESPACE=rhmap-rhmap-myEnvironmentName
```
