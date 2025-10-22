$response = Invoke-WebRequest "http://localhost:8008/ServiceCheck.aspx" -UseBasicParsing;
if ($response.StatusCode -eq 200) { exit 0 }
exit 1
