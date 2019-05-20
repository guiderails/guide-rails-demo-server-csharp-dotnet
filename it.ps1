$port = "8080"
if ($null -ne $env:DEMOSERVER.PORT) {
    $port = $env:DEMOSERVER.PORT
}

# $r = Invoke-WebRequest -Uri "http://localhost:$port/"
$r = Invoke-WebRequest -Uri "http://localhost:8080/"
if (200 -ne $r.StatusCode) {
    throw "Integration test failed"
}
Write-Host "Integration tests passed!"
