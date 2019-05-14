Add-Type -assembly "system.io.compression.filesystem"
$archiveName = "$env:PKG_BASE_DIR/$env:APPLICATION_NAME/netdemo-server.zip"
Write-Output "Extracting Archive: $archiveName"
[io.compression.zipfile]::ExtractToDirectory($archiveName, "$env:PKG_BASE_DIR/$env:APPLICATION_NAME")
Write-Output "Done Extracting"

$Command = "$env:PKG_BASE_DIR/$env:APPLICATION_NAME/netdemo-server.exe"
Invoke-Expression $Command

$healthprocess = Get-Process netdemo-Server -ErrorAction SilentlyContinue
if ($null -eq $healthprocess) {
    Get-Process
    throw [System.Exception] "application not started"
}
