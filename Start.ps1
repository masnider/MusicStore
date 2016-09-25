$sql_server_container_id = docker run -p 1433:1433 -d -e SA_PASSWORD=Bar123 sqlserver:2016
$sqlserver_ip = docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" $sql_server_container_id
Write-Host "sqlserver_ip: $sqlserver_ip"

$musicstore_container_id = docker run -p 5000:5000 -d -e ConnectionString="Server=$sqlserver_ip;Database=MusicStore;Integrated Security=False;User Id=sa;Password=Bar123;MultipleActiveResultSets=True;Connect Timeout=30" musicstore
$musicstore_ip = docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" $musicstore_container_id
Write-Host "musicstore_ip: $musicstore_ip"
