Write-Host "Starting SPIRE server .."
docker-compose up -d --wait spire-server

Write-Host "Creating entries..."
docker-compose up -d --wait create-entries

# commented out because using insecure_bootstrap
#Write-Host "Bootstrapping SPIRE Agent..."
#docker-compose exec -T spire-server /opt/spire/bin/spire-server bundle show > spire/agent/conf/trust_bundle.pem

Write-Host "Starting SPIRE agent .."
docker-compose up -d --wait spire-agent

Write-Host "Starting spire-workload ..."
docker-compose up -d spire-workload
