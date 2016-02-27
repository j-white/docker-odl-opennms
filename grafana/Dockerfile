# Grafana DockerFile
# Based on Debian
# https://registry.hub.docker.com/_/debian/
FROM debian:8.3
MAINTAINER Jesse White <jesse@opennms.org>

# Install Grafana with the OpenNMS plugin
RUN apt-get update && \
    apt-get -y --no-install-recommends install libfontconfig curl ca-certificates && \
    apt-get clean && \
    curl https://grafanarel.s3.amazonaws.com/builds/grafana_2.6.0_amd64.deb > /tmp/grafana.deb && \
    dpkg -i /tmp/grafana.deb && \
    rm /tmp/grafana.deb && \
    curl http://debian.opennms.org/dists/stable/main/binary-all/grafana-opennms-plugin_1.1.0-2_all.deb > /tmp/plugin.deb && \
    dpkg -i /tmp/plugin.deb && \
    rm /tmp/plugin.deb && \
    curl -L https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64 > /usr/sbin/gosu && \
    chmod +x /usr/sbin/gosu && \
    apt-get remove -y curl && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

COPY scripts/run.sh /run.sh

EXPOSE 3000

ENTRYPOINT ["/run.sh"]
