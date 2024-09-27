#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail


echo "Starting SPIRE Server"
docker-compose up -d spire-server

echo "bootstrapping SPIRE Agent..."
docker-compose exec -T spire-server /opt/spire/bin/spire-server bundle show > "${PARENT_DIR}"/spire/agent/bootstrap.crt

echo "Starting SPIRE Agent"
docker-compose up -d spire-agent
