#7z.exe e .\netdemo-server.zip
Add-Type -assembly "system.io.compression.filesystem"
$archiveName = "$env:PKG_BASE_DIR/$env:APPLICATION_NAME/netdemo-server.zip"
Write-Output "Extracting Archive: $archiveName"
[io.compression.zipfile]::ExtractToDirectory($archiveName, "$env:PKG_BASE_DIR/$env:APPLICATION_NAME")
Write-Output "Done Extracting"

#Start-Process .\netdemo-Server.exe

$Command = "$env:PKG_BASE_DIR/$env:APPLICATION_NAME/netdemo-server.exe"
Invoke-Expression $Command

$healthprocess = Get-Process netdemo-Server -ErrorAction SilentlyContinue
if ($null -eq $healthprocess) {
	throw [System.Exception] "application not started"
}
