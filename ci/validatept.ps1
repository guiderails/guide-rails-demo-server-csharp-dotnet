$limit = 10.0
if ($null -ne $env:PERFORMANCE_LIMIT) {
    $limit = $env:PERFORMANCE_LIMIT
}

$pt = Import-Csv -Path results.jtl
$avg = ($pt | Measure-Object -Property 'elapsed' -Average).Average
Write-Host "Average response time: $avg"

if ($limit -le $avg) {
    throw "Performance Test exceeded $limit"
}
Write-Host "Performance under $limit."
