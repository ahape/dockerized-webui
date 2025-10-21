$response = Invoke-WebRequest "http://localhost/ServiceCheck.aspx" -UseBasicParsing;
if ($response.StatusCode -eq 200) { exit 0 }
exit 1
