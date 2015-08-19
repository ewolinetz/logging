#!/bin/bash
set -e
sh gen_root_ca.sh capass tspass
sh generateJKSChain.sh es-logging kspass capass && sh generatePEMCerts.sh fluentd-elasticsearch kspass capass && sh generatePEMCerts.sh kibana kspass capass
cp ca/root-ca.crt fluentd-elasticsearch/
cp ca/root-ca.crt kibana/
cp truststore.jks es-logging/
