# OpenNMS meets Opendaylight

Dockerfiles for working with the Opendaylight integration in OpenNMS

## Usage

```sh
docker-compose build
docker-compose up
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
