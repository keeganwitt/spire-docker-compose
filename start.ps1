Write-Host "Starting SPIRE Server"
docker-compose up -d spire-server

Start-Sleep -Seconds 5

Write-Host "bootstrapping SPIRE Agent..."
docker-compose exec -T spire-server /opt/spire/bin/spire-server bundle show > spire/agent/bootstrap.crt

Write-Host "Starting SPIRE Agent"
docker-compose up -d spire-agent
