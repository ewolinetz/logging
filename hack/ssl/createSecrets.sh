#! /bin/bash

# clean up old secrets
echo "Cleaning up existing secrets"
oc delete secret fluentd
oc delete secret elasticsearch
oc delete secret kibana

echo "Creating secrets..."
# create secret for fluentd
oc secrets new fluentd cert=$PWD/fluentd-elasticsearch/fluentd-elasticsearch.crt key=$PWD/fluentd-elasticsearch/fluentd-elasticsearch.key ca=$PWD/fluentd-elasticsearch/root-ca.crt

# create secret for ES
oc secrets new elasticsearch key=$PWD/es-logging/es-logging-keystore.jks truststore=$PWD/es-logging/truststore.jks

# create secret for kibana
oc secrets new kibana cert=$PWD/kibana/kibana.crt key=$PWD/kibana/kibana.key ca=$PWD/kibana/root-ca.crt

echo "Assigning secrets to default"
# assign secrets to default for mount
oc secrets add serviceaccount/default secrets/fluentd --for=mount
oc secrets add serviceaccount/default secrets/elasticsearch --for=mount
oc secrets add serviceaccount/default secrets/kibana --for=mount
