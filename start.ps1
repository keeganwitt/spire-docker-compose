Write-Host "Starting SPIRE server .."
docker-compose up -d --wait spire-server

Write-Host "Creating entries..."
docker-compose exec -T spire-server /opt/spire/bin/spire-server entry create `
    -selector docker:label:com.docker.compose.service:spiffe-helper `
    -spiffeID spiffe://example.org/workload/spiffe-helper `
    -parentID spiffe://example.org/spire/agent/x509pop/02b8e7713492fdf93d43369e9c6f50d28bef9fa8
#    -parentID spiffe://example.org/node/agent

# commented out because using insecure_bootstrap
#Write-Host "Bootstrapping SPIRE Agent..."
#docker-compose exec -T spire-server /opt/spire/bin/spire-server bundle show > spire/agent/conf/trust_bundle.pem

Write-Host "Starting SPIRE agent .."
docker-compose up -d --wait spire-agent

Write-Host "Starting spiffe-helper ..."
docker-compose up -d spiffe-helper
