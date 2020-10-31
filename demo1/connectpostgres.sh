#!/bin/sh
curl -X POST -H "Accept:application/json" -H "Content-Type:application/json" -d @postgres.json localhost:8083/connectors/ | jq
