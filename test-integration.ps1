# builds in debug, runs integration tests
$VSINSTALLDIR_2017 = "\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise"

if ($null -ne $env:VSINSTALLDIR_2017) {
	$VSINSTALLDIR_2017 = $env:VSINSTALLDIR_2017
}

MSBuild.exe /t:Rebuild /p:Configuration=debug

$proc = Start-Process "$VSINSTALLDIR_2017\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe" -ArgumentList "/TestCaseFilter:Category=Integration netdemo-Server\bin\Debug\netdemo-Server.exe" -PassThru -NoNewWindow -Wait
$ec = $proc.ExitCode
"Exit code: {0}" -f $ec

if (0 -ne $ec) {
	throw "Integration tests failed."
}
