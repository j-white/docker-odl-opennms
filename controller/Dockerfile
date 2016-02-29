# OpenDaylight Beryllium DockerFile
# Based on Debian
# https://registry.hub.docker.com/_/debian/
FROM debian:8.3
MAINTAINER Jesse White <jesse@opennms.org>

# Install required software
# ODL doesn't require a JDK, but OpenNMS does, so this allows us to reuse the same image
RUN echo "deb http://httpredir.debian.org/debian jessie-backports main contrib non-free" > /etc/apt/sources.list.d/backports.list && \
    apt-get update && \
    apt-get install -y openjdk-8-jdk openjdk-8-jre-headless wget vim

# Download and install ODL
WORKDIR /opt
RUN mkdir opendaylight

RUN wget -qO distribution-karaf.tar.gz http://www.opennms.org/~jesse/odl/distribution-karaf-0.4.0-Beryllium-nms-02292016.tar.gz && \
    tar -xf distribution-karaf.tar.gz -C opendaylight --strip-components=1 && \
    rm distribution-karaf.tar.gz

# HACK: Fix issue with JMX ACLs
RUN rm -f /opt/opendaylight/etc/jmx.acl.*

# Fix bug related to terminal capabilities negotiation
RUN wget -qO /opt/opendaylight/system/org/apache/sshd/sshd-core/0.12.0/sshd-core-0.12.0.jar http://search.maven.org/remotecontent?filepath=org/apache/sshd/sshd-core/0.14.0/sshd-core-0.14.0.jar

COPY scripts/bootstrap.sh /opt/opendaylight/bin
COPY etc /opt/opendaylight/etc

# Ports
# 162 - SNMP4SDN (only when started as root)
# 179 - BGP
# 1088 - JMX access
# 1790 - BGP/PCEP
# 1830 - Netconf
# 2400 - OSGi console
# 2550 - ODL Clustering
# 2551 - ODL Clustering
# 2552 - ODL Clustering
# 4189 - PCEP
# 4342 - Lisp Flow Mapping
# 5005 - JConsole
# 5666 - ODL Internal clustering RPC
# 6633 - OpenFlow
# 6640 - OVSDB
# 6653 - OpenFlow
# 7800 - ODL Clustering
# 8000 - Java debug access
# 8080 - OpenDaylight web portal
# 8101 - KarafSSH
# 8181 - MD-SAL RESTConf and DLUX
# 8383 - Netconf
# 12001 - ODL Clustering
EXPOSE 162 179 1088 1790 1830 2400 2550 2551 2552 4189 4342 5005 5666 6633 6640 6653 7800 8000 8080 8101 8181 8383 12001

WORKDIR /opt/opendaylight
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
CMD ["/opt/opendaylight/bin/bootstrap.sh"]
