sed -i "s/es_host/$ES_HOST/" /opt/openshift/src/config/kibana.yml
sed -i "s/es_port/$ES_PORT/" /opt/openshift/src/config/kibana.yml

kibana
