#! /bin/bash

nohup /usr/share/elasticsearch/bin/elasticsearch -Des.pidfile=/var/run/elasticsearch/elasticsearch.pid &
sleep 15; /usr/share/elasticsearch/bin/plugin -i com.floragunn/search-guard/0.5
sleep 30; kill `cat /var/run/elasticsearch/elasticsearch.pid`