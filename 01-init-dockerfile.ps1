$text = gc Dockerfile
$text = $text.Replace("%AZURE_CLIENT_ID%", $env:AZURE_CLIENT_ID)
$text = $text.Replace("%AZURE_CLIENT_SECRET%", $env:AZURE_CLIENT_SECRET)
$text = $text.Replace("%AZURE_TENANT_ID%", $env:AZURE_TENANT_ID)
echo $text > Dockerfile

