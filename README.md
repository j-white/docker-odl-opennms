# OpenNMS meets Opendaylight

Dockerfiles for working with the Opendaylight integration in OpenNMS

## Option 1) Use precompiled binaries

```sh
wget -O controller/distribution-karaf.tar.gz http://www.opennms.org/~jesse/odl/distribution-karaf-0.4.0-Beryllium-nms-02262016.tar.gz
```

Fire it up:
```sh
docker-compose up
```

## Option 2) Building from source

### Newts

Compile [Newts](https://github.com/OpenNMS/newts) from source using the `jira/NEWTS-80` branch.

### Opendaylight

Compile ODL Beryllium from source replacing the *tsdr* project with the one available in the `newts` branch of [j-white/tsdr](https://github.com/j-white/tsdr)

### OpenNMS

Compile [OpenNMS](https://github.com/OpenNMS/opennms) from source using the `features/odl-integration` branch.
