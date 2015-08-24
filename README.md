# logging
The purpose of this repo is to create the components of the logging stack via Dockerfiles `cd hack; sh build-images.sh` and then deploy them via a single yaml file `oc create -f logging.yml`.

To use the mutual auth to connect to ElasticSearch you will need to create a JKS keychain and truststore for Elasticsearch, and unencrypted certificates and pkeys for Fluentd and Kibana.  The script hack/ssl/generateExampleKeys.sh will do this for you.  Then, you will need to configure secrets so that the containers can use these keys, if you ran generateExampleKeys.sh you can then run hack/ssl/createSecrets.sh and it will create the secrets and add them to the default service account.

You will also need to update the value of the 'K8S_HOST_URL' variable in the logging.yml template to be the value of the host ip/dname where your Kubernetes api is available at.
To allow fluentd to list all pods in the cluster, you will need to update the role of your service account.  Assuming you are using system:serviceaccount:default:default you can use the following command.  Please note this is not recommended for Production at this time.
```
oadm policy add-cluster-role-to-user cluster-reader system:serviceaccount:default:default
```

At this point you can create the stack using logging.yml.
