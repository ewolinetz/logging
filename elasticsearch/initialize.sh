#! /bin/bash

nohup /usr/share/elasticsearch/bin/elasticsearch -Des.pidfile=/var/run/elasticsearch/elasticsearch.pid &

sleep 30; curl -XPUT 'http://localhost:9200/searchguard/ac/ac?pretty' -d '
{"acl": [
    {
      "__Comment__": "Default is to deny all access",
      "filters_bypass": [],
      "filters_execute": []
    },
    {
      "__Comment__": "Any authenticated user do anything on the 'public' index - no filter will be executed",
      "indices": ["public"],
      "filters_bypass": ["*"],
      "filters_execute": []
    },
    {
      "__Comment__": "This means that every requestor (regardless of the requestors hostname and username) which has the root role can do anything",
      "roles": [
        "root"
      ],
      "filters_bypass": ["*"],
      "filters_execute": []
    },
    {
      "__Comment__": "This is so that fluentd can only write",
      "users": ["fluentd"],
      "filters_bypass": [],
      "filters_execute": ["actionrequestfilter.fluentd"]
    },
    {
      "__Comment__": "This is so that kibana can do anything with the .kibana index",
      "users": ["kibana"],
      "indices": [".kibana"],
      "filters_bypass": [*],
      "filters_execute": []
    },
    {
      "__Comment__": "This is so that kibana can read for every other index",
      "users": ["kibana"],
      "filters_bypass": [],
      "filters_execute": ["actionrequestfilter.kibana"]
    }
]}'

/usr/share/elasticsearch/bin/plugin -i com.floragunn/search-guard/0.5

kill `cat /var/run/elasticsearch/elasticsearch.pid`