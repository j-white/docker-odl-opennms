#!/bin/bash

# Wait for the API to be accessible
while true; do
  curl -u admin:admin "http://127.0.0.1:3000/api/datasources" 2>&1 > /dev/null && break
  sleep 10
done

# Build the URL to the linked OpenNMS container
OPENNMS_URL="http://${OPENNMS_PORT_8980_TCP_ADDR}:${OPENNMS_PORT_8980_TCP_PORT}/opennms"

cat <<EOT > /tmp/datasource.json
{
  "id":1,
  "orgId":1,
  "name":"OpenNMS",
  "type":"opennms",
  "access":"proxy",
  "url":"${OPENNMS_URL}",
  "password":"",
  "user":"",
  "database":"",
  "basicAuth":true,
  "basicAuthUser":"admin",
  "basicAuthPassword":"admin",
  "isDefault":true,
  "jsonData":null
}
EOT

# Create or update the datasource, one of these should execute succesfully
curl -u admin:admin -H "Content-Type: application/json" -X POST -d @/tmp/datasource.json "http://127.0.0.1:3000/api/datasources"
curl -u admin:admin -H "Content-Type: application/json" -X PUT -d @/tmp/datasource.json "http://127.0.0.1:3000/api/datasources/1"
