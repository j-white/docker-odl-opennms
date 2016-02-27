# OpenNMS DockerFile
# Based on Debian
# https://registry.hub.docker.com/_/debian/
FROM debian:8.3
MAINTAINER Jesse White <jesse@opennms.org>

# Install required software
RUN echo "deb http://httpredir.debian.org/debian jessie-backports main contrib non-free" > /etc/apt/sources.list.d/backports.list && \
    apt-get update && \
    apt-get install -y openjdk-8-jdk openjdk-8-jre-headless wget

# Install OpenNMS essentials
RUN wget -qO - http://debian.opennms.org/OPENNMS-GPG-KEY | apt-key add - && \
    echo "deb http://debian.opennms.org stable main" > /etc/apt/sources.list.d/opennms.list && \
    apt-get update && \
    apt-get install -y jicmp jicmp6 jrrd rrdtool net-tools 

# Download and install OpenNMS
WORKDIR /opt
RUN mkdir opennms

RUN wget -qO opennms.tar.gz http://www.opennms.org/~jesse/odl/opennms-18.0.0-SNAPSHOT-odl-02262016.tar.gz && \
    tar -xf opennms.tar.gz -C opennms && \
    rm opennms.tar.gz

COPY scripts/bootstrap.sh /opt/opennms/bin
 
# Ports
# 8101 - Karaf SSH
# 8980 - OpenNMS WebUI
# 61616 - ActiveMQ
EXPOSE 8101 8980 61616

WORKDIR /opt/opennms
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
CMD ["/opt/opennms/bin/bootstrap.sh"]
