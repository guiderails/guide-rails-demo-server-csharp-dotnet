Add-Type -assembly "system.io.compression.filesystem"
$archiveName = "$env:PKG_BASE_DIR/$env:APPLICATION_NAME/netdemo-server.zip"
Write-Output "Extracting Archive: $archiveName"
[io.compression.zipfile]::ExtractToDirectory($archiveName, "$env:PKG_BASE_DIR/$env:APPLICATION_NAME")
Write-Output "Done Extracting"

$port = "8081"
if ($null -ne $env:DEMOSERVER_PORT) {
    $port = $env:DEMOSERVER_PORT
}

$machine = Test-Connection $env:computername -count 1 | Select-Object Ipv4Address
$machine = $machine.Ipv4Address
$Command = "$env:PKG_BASE_DIR/$env:APPLICATION_NAME/netdemo-server.exe $machine $port"
Invoke-Expression $Command

$healthprocess = Get-Process netdemo-Server -ErrorAction SilentlyContinue
if ($null -eq $healthprocess) {
    Get-Process
    throw [System.Exception] "application not started"
} else {
    Write-Host "Application has started."
    ipconfig.exe
}
