$text = gc Dockerfile
$text.Replace("%SECRET_GOES_HERE", $env:AZURE_CLIENT_SECRET)
echo $text > Dockerfile

