#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

echo "Starting SPIRE server ..."
docker-compose up -d --wait spire-server

echo "Creating entries..."
docker-compose up -d --wait create-entries

# commented out because using insecure_bootstrap
#echo "Bootstrapping SPIRE Agent..."
#docker-compose exec -T spire-server /opt/spire/bin/spire-server bundle show > spire/agent/conf/trust_bundle.pem

echo "Starting SPIRE agent ..."
docker-compose up -d --wait spire-agent

echo "Starting spiffe-helper ..."
docker-compose up -d spiffe-helper
