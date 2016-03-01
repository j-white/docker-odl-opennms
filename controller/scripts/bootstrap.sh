#! /bin/bash
ODL_HOME=/opt/opendaylight

# Use the linked Cassandra container for Newts
export NEWTS_HOST="${CASSANDRA_PORT_9042_TCP_ADDR}"
export NEWTS_PORT="${CASSANDRA_PORT_9042_TCP_PORT}"

export NEWTS_RESOURCE_PREFIX="snmp:fs:NODES:"
export NEWTS_RESOURCE_SUFFIX=":stats"

export ACTIVEMQ_HOST="${QPID_PORT_5672_TCP_ADDR}"
export ACTIVEMQ_PORT="${QPID_PORT_5672_TCP_PORT}"

"${ODL_HOME}/bin/karaf" clean server
