#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

echo "Starting SPIRE server ..."
docker-compose up -d --wait spire-server

echo "Creating entries..."
#docker-compose exec -T spire-server -config /opt/spire/conf/server/server.conf /opt/spire/bin/spire-server entry-create -selector unix:uid:0 -spiffeID spiffe://example.org/spiffe-helper -parentID spiffe://example.org/spire/agent/x509pop/02b8e7713492fdf93d43369e9c6f50d28bef9fa8
#docker-compose exec -T spire-server -config /opt/spire/conf/server/server.conf /opt/spire/bin/spire-server entry-create -selector unix:uid:0 -spiffeID spiffe://example.org/spiffe-helper -parentID spiffe://example.org/node/agent
#docker-compose exec -T spire-server /opt/spire/bin/spire-server entry create -selector docker:image_id:spiffe-helper:latest -spiffeID spiffe://example.org/workload/spiffe-helper -parentID spiffe://example.org/node/agent
docker-compose exec -T spire-server /opt/spire/bin/spire-server entry create -selector docker:image_id:spiffe-helper:latest -spiffeID spiffe://example.org/workload/spiffe-helper -parentID spiffe://example.org/spire/agent/x509pop/02b8e7713492fdf93d43369e9c6f50d28bef9fa8

# commented out because using insecure_bootstrap
#echo "Bootstrapping SPIRE Agent..."
#docker-compose exec -T spire-server /opt/spire/bin/spire-server bundle show > spire/agent/conf/trust_bundle.pem

echo "Starting SPIRE agent ..."
docker-compose up -d --wait spire-agent

echo "Starting workload ..."
docker-compose up -d spire-workload
