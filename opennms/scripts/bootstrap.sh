#! /bin/bash
OPENNMS_HOME=/opt/opennms

echo "OPENNMS HOME: "${OPENNMS_HOME}

# Point PostgreSQL to the linked container
sed -i 's|url=.*opennms.*|url="jdbc:postgresql://'"${POSTGRES_PORT_5432_TCP_ADDR}:${POSTGRES_PORT_5432_TCP_PORT}/opennms"'"|g' "${OPENNMS_HOME}/etc/opennms-datasources.xml"
sed -i 's|url=.*template1.*|url="jdbc:postgresql://'"${POSTGRES_PORT_5432_TCP_ADDR}:${POSTGRES_PORT_5432_TCP_PORT}/template1"'"|g' "${OPENNMS_HOME}/etc/opennms-datasources.xml"

# Expose the Karaf shell
sed -i s/sshHost.*/sshHost=0.0.0.0/g "${OPENNMS_HOME}/etc/org.apache.karaf.shell.cfg"

# Enable Newts
sed -i s/.*org\.opennms\.timeseries\.strategy.*/org.opennms.timeseries.strategy=newts/g "${OPENNMS_HOME}/etc/opennms.properties"

# Enable storeByFS
sed -i s/.*org\.opennms\.rrd\.storeByForeignSource.*/org.opennms.rrd.storeByForeignSource=true/g "${OPENNMS_HOME}/etc/opennms.properties"

# Use the linked Cassandra container
sed -i s/.*org.opennms.newts.config.hostname.*/org.opennms.newts.config.hostname=${CASSANDRA_PORT_9042_TCP_ADDR}/g "${OPENNMS_HOME}/etc/opennms.properties"
sed -i s/.*org.opennms.newts.config.port.*/org.opennms.newts.config.port=${CASSANDRA_PORT_9042_TCP_PORT}/g "${OPENNMS_HOME}/etc/opennms.properties"

# Use the linked Controller container
sed -i "s|odl.*NODES|odl://${CONTROLLER_PORT_8181_TCP_ADDR}:${CONTROLLER_PORT_8181_TCP_PORT}/NODES|g" "${OPENNMS_HOME}/etc/provisiond-configuration.xml"

# Start OpenNMS
${OPENNMS_HOME}/bin/runjava -s
${OPENNMS_HOME}/bin/install -dis
${OPENNMS_HOME}/bin/newts init
"${OPENNMS_HOME}/bin/opennms" -f start
