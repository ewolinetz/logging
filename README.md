# logging
The purpose of this repo is to create the components of the logging stack via Dockerfiles `cd hack; sh build-images.sh` and then deploy them via a single yaml file `oc create -f logging.yml`.

To use the mutual auth to connect to ElasticSearch you will need to create a JKS keychain and truststore for Elasticsearch, and unencrypted certificates and pkeys for Fluentd and Kibana.  The script hack/ssl/generateExampleKeys.sh will do this for you.  Then, you will need to configure secrets so that the containers can use these keys, if you ran generateExampleKeys.sh you can then run hack/ssl/createSecrets.sh and it will create the secrets and add them to the default service account.

At this point you can create the stack using logging.yml.