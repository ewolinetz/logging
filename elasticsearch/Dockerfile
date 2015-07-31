FROM openshift/base-centos7

MAINTAINER Eric Wolinetz <ewolinet@redhat.com>

EXPOSE 9200
EXPOSE 9300

ENV JAVA_VER=1.8.0 \
  ES_VER=1.5.2

LABEL io.k8s.description="Elasticsearch container for allowing indexing and searching of aggregated logs" \
  io.k8s.display-name="Elasticsearch 1.5.2" \
  io.openshift.expose-services="9200:http, 9300:http" \
  io.openshift.tags="logging,elk,elasticsearch"

COPY elasticsearch.repo /etc/yum.repos.d/elasticsearch.repo

RUN rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch && \
  yum install -y -- setopt=tsflags=nodocs \
  java-1.8.0-openjdk \
  elasticsearch

RUN mkdir -p /usr/share/elasticsearch/config && \
  cp /etc/elasticsearch/* /usr/share/elasticsearch/config

#VOLUME /usr/share/elasticsearch/data

COPY initialize.sh /opt/app-root/src/initialize.sh
RUN sh initialize.sh
COPY elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
COPY logging.yml /usr/share/elasticsearch/config/logging.yml

RUN chmod -R og+w /usr/share/elasticsearch

USER default

#CMD ["/usr/share/elasticsearch/bin/elasticsearch", "-Des.pidfile=/var/run/elasticsearch/elasticsearch.pid"]
#CMD ["/usr/share/elasticsearch/bin/elasticsearch", "-Des.logger.level=WARN"]
CMD ["/usr/share/elasticsearch/bin/elasticsearch"]