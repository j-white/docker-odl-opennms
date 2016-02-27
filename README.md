# OpenNMS meets Opendaylight

Dockerfiles for working with the Opendaylight integration in OpenNMS

## Usage

```sh
docker-compose build
docker-compose up
```

Wait for OpenNMS to load and trigger an import:

```sh
docker exec -it odl-opennms /bin/bash -c '/opt/opennms/bin/send-event.pl uei.opennms.org/internal/importer/reloadImport -p "url odl://${CONTROLLER_PORT_8181_TCP_ADDR}:${CONTROLLER_PORT_8181_TCP_PORT}/NODES"'
```

## Building from source

The Dockerfiles reference binaries hosted on http://www.opennms.org/~jesse/

These were compiled from:

### Newts

Compile [Newts](https://github.com/OpenNMS/newts) from source using the `jira/NEWTS-80` branch.

### Opendaylight

Compile ODL Beryllium from source replacing the *tsdr* project with the one available in the `newts` branch of [j-white/tsdr](https://github.com/j-white/tsdr)

### OpenNMS

Compile [OpenNMS](https://github.com/OpenNMS/opennms) from source using the `features/odl-integration` branch.
