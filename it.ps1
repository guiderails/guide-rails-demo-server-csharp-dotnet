$r = Invoke-WebRequest http://localhost:8080/
if (200 -ne $r.StatusCode) { throw "Integration test failed" }