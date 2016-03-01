FROM fedora/qpid
MAINTAINER Jesse White <jesse@opennms.org>

RUN dnf install -y qpid-tools

COPY scripts/add-topic.sh /add-topic.sh
COPY scripts/run.sh /run.sh

ENTRYPOINT ["/run.sh"]
