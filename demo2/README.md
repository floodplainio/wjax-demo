This Floodplain app runs 'kafkaless', so there is no Kafka cluster, even though
there _is_ a kafka streams instance.

To get started, start the docker compose:
```
docker-compose up
```

This will start two containers: 
 - A postgres database with change capture enabled, and a small datamodel of movie rentals.
 - A simple application that inserts random payments into the payment table. It is a Quarkus / Kotlin app, but it could be anything.

Switch to a new terminal when this is running

Aside from that:

```
./gradlew run
```
should do the trick!

Once it is running, it will stream and join Postgres changes to ElasticSearch.

You can query ElasticSearch using cURL, there are many online tutorials, but in a nutshell:
```
curl 'http://localhost:9200/_search?q=<QUERY>'
``` 

To look for example for a customer in Vietnam named Greg:
```
curl 'http://localhost:9200/_search?q=Vietnam%20AND%20Greg' | jq
```
(Also added a pipe though jq to format the JSON to make it readable)

The first, highest scoring hit should be a customer called Greg in Vietnam. There will be other results with lower scores: Other people named Greg, or other customers living in Vietnam.

Once you're done, don't forget to CTRL+C the docker-compose window. If you want to re-run the demo with clean data remember to delete the containers first using:
```
docker-compose rm -f
```

