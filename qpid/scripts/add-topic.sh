#!/bin/bash

# Wait for qpid be accessible
sleep 30

qpid-config add exchange topic event
qpid-config add queue Queue-Opendaylight
qpid-config bind event Queue-Opendaylight
