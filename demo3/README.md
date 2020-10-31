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

In order to run this, you'll need to create a json based Google Docs credential file.

Then, point to that by pointing the GOOGLE_SHEETS_CREDENTIAL_PATH environment variable to that file.
Also you should make a spreadsheet and copy its id to the source file.

Aside from that:

```
./gradlew run
```
should do the trick!

Once you're done, don't forget to CTRL+C the docker-compose window. If you want to re-run the demo with clean data remember to delete the containers first using:
```
docker-compose rm -f
```

Note: The google sheet sink does not support deletes!
(PR's welcome ;-))


