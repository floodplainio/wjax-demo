# Welcome to WJAX!

So first, clone this repository somewhere.

This repository only contains one real file, a docker compose file that starts a bunch of containers. I'll list them here to explain their function.

This is the backdrop of all our demos. Make sure to have this up and running before trying the examples.

Also, make sure you have the kafka tools installed, and a postgres client is welcome as well.

**Beware, there are a lot of moving parts, most are JVM based, so make sure your docker setup has enough memory to work with. On my macbook, 3Gb seems to work fine**

Start the demo setup with:

```bash
docker-compose up
```

After a while the logs should die down and the demo setup is up and running.
To shut it down, CTRL+C the console, and if you want to reset all the data:

```bash
docker-compose rm
```

List topics:
```bash
kafka-topics --bootstrap-server localhost:9092 --list
```

Follow a topic:
```bash
kafka-console-consumer --bootstrap-server localhost:9092 --topic Generic-test-dvd.public.staff --from-beginning| jq
```

Note: The demo app will keep adding data to postgres, so this database will get large if you leave it running for very long.

You can play with the database by connecting to the database:
```bash
psql -h localhost --user postgres --dbname dvdrental
```
(password is 'mysecretpassword')

### floodplain/floodplain-postgres-demo

This is an example dataset, added to a debezium postgres instance. It is a regular postgres database (but with change capture enabled) and with an example dataset.

If you have some database client, you can connect to it like this:

jdbc:postgresql://localhost/dvdrental

Username: postgress Password: mysecretpassword

The schema we're using is 'public', and there are about 15 tables with data about (fictional) films, actors, customers and stores.

### floodplain/cdcservice:0.0.1

A tiny Kotlin service that slowly inserts data into the 'payment' table of postgres. Later we will use this to show the change data capture.

If you want to see how it works, the source is here:

https://github.com/floodplainio/floodplain-cdc.git

However one of the big selling points of change data capture is that you don't really need to know how the 'original' application works. It does not matter if it is written in Kotlin or in Cobol, we will only use the change capture feed.

### A Kafka cluster

- image: wurstmeister/zookeeper
- image: wurstmeister/kafka:2.13-2.6.0

We'll also start a kafka cluster, and for that we also need a zookeeper instance. Note that in any kind of serious setup you would not run zookeeper or kafka on a single node, but for demo purposes it is fine.

### Kafka Connect

- image: floodplain/debezium-with-mongodb:1.0.1

This is a debezium connector, enhanced with a HTTP connector, a very experimental Google Sheets connector and a (standard) MongoDB connector.

This is the Kafka Connect instance (exposing http://localhost:8083) where it receives commands.

