#!/bin/sh

chown -R grafana:grafana /var/lib/grafana /var/log/grafana

/add-datasource.sh &

exec gosu grafana /usr/sbin/grafana-server  \
  --homepath=/usr/share/grafana             \
  --config=/etc/grafana/grafana.ini         \
  cfg:default.paths.data=/var/lib/grafana   \
  cfg:default.paths.logs=/var/log/grafana
