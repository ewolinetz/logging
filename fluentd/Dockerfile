FROM openshift/base-centos7

MAINTAINER Eric Wolinetz <ewolinet@redhat.com>

ENV RUBY_VERSION=2.0 \
  FLUENTD_VERSION=0.12.6 \
  GEM_HOME=/opt/app-root/src

RUN yum install -y --setopt=tsflags=nodocs \
  ruby \
  ruby-devel \
  libcurl-devel \
  make && \
  mkdir -p ${HOME}

LABEL io.k8s.description="Fluentd container for collecting of docker container logs" \
  io.k8s.display-name="Fluentd 0.12.6" \
  io.openshift.expose-services="9200:http, 9300:http" \
  io.openshift.tags="logging,elk,fluentd"

RUN gem install fluentd fluent-plugin-kubernetes_metadata_filter fluent-plugin-elasticsearch

COPY out_elasticsearch.rb /opt/app-root/src/gems/fluent-plugin-elasticsearch-0.9.0/lib/fluent/plugin/out_elasticsearch.rb
COPY fluent.conf /etc/fluent/fluent.conf
#COPY root-ca.crt /etc/fluent/keys/root-ca.crt
#COPY fluentd-elasticsearch-pkey.key /etc/fluent/keys/fluentd-elasticsearch-pkey.key
#COPY fluentd-elasticsearch-signed.crt /etc/fluent/keys/fluentd-elasticsearch-signed.crt

CMD ["fluentd"]
