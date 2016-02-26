# OpenDaylight Beryllium DockerFile
# Based on Debian
# https://registry.hub.docker.com/_/debian/
FROM debian:8.3
MAINTAINER Jesse White <jesse@opennms.org>

# Install required software (170MB)
RUN apt-get update && apt-get install -y openjdk-7-jre-headless wget

# Download and install ODL
WORKDIR /opt
RUN mkdir opendaylight
COPY distribution-karaf.tar.gz /opt

RUN tar -xf distribution-karaf.tar.gz -C opendaylight --strip-components=1 && \
    rm distribution-karaf.tar.gz

# Setup our featuresBoot
RUN echo '\
featuresRepositories = mvn:org.apache.karaf.features/standard/3.0.3/xml/features,mvn:org.apache.karaf.features/enterprise/3.0.3/xml/features,mvn:org.ops4j.pax.web/pax-web-features/3.1.4/xml/features,mvn:org.apache.karaf.features/spring/3.0.3/xml/features,mvn:org.opendaylight.integration/features-integration-index/0.4.0-Beryllium/xml/features\n\
featuresBoot = config,standard,region,package,kar,ssh,management,odl-mdsal-clustering,odl-restconf,odl-l2switch-switch,odl-mdsal-apidocs,odl-dlux-core,odl-l2switch-switch-ui,odl-dlux-yangui,odl-tsdr-newts,odl-tsdr-openflow-statistics-collector\n'\
> /opt/opendaylight/etc/org.apache.karaf.features.cfg

# HACK: Fix issue with JMX ACLs
RUN rm -f /opt/opendaylight/etc/jmx.acl.* && echo '\
list* = *\n'\
get* = *\n'\
is* = *\n'\
set* = *\n'\
* = *\n'\
> /opt/opendaylight/etc/jmx.acl.cfg


# Fix bug related to terminal capabilities negotiation
RUN cp /opt/opendaylight/system/org/apache/sshd/sshd-core/0.14.0/sshd-core-0.14.0.jar /opt/opendaylight/system/org/apache/sshd/sshd-core/0.12.0/sshd-core-0.12.0.jar

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
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/jre
CMD ["./bin/karaf", "server"]
