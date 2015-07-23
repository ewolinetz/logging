FROM openshift/base-centos7

MAINTAINER Eric Wolinetz <ewolinet@redhat.com>

ENV RUBY_VERSION=2.0 \
  FLUENTD_VERSION=0.12.6 \
  GEM_HOME=/opt/openshift/src

RUN yum install -y --setopt=tsflags=nodocs \
  ruby \
  ruby-devel

LABEL io.k8s.description="Fluentd container for collecting of docker container logs" \
  io.k8s.display-name="Fluentd 0.12.6" \
  io.openshift.expose-services="9200:http, 9300:http" \
  io.openshift.tags="logging,elk,fluentd"

COPY fluent.conf /etc/fluent/fluent.conf

RUN gem install fluentd fluent-plugin-kubernetes_metadata_filter fluent-plugin-elasticsearch

CMD ["fluentd"]

