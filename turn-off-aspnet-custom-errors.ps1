# Disable custom errors to see the actual exception
docker exec brightmetrics-web powershell -Command @"
`$webConfigPath = 'C:\inetpub\wwwroot\web.config'
`$xml = [xml](Get-Content `$webConfigPath)
`$customErrors = `$xml.configuration.'system.web'.customErrors
`$customErrors.mode = 'Off'
`$xml.Save(`$webConfigPath)
"@

# Restart the app pool to apply changes
docker exec brightmetrics-web powershell -Command "Import-Module WebAdministration; Restart-WebAppPool BrightMetricsPool"

write-host "done"

# Now try again - you'll see the real error
#Invoke-WebRequest http://localhost:8080/ServiceCheck.aspx
