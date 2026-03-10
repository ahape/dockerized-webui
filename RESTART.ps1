param([switch]$NoCopy = $false)

docker stop brightmetrics-web

docker rm brightmetrics-web

if (-not $NoCopy) {
  ./scripts/copy-web-content.ps1
}

docker build -t brightmetrics-web:latest .

docker run -d --name brightmetrics-web --isolation=hyperv -p 8008:8008 brightmetrics-web:latest

./scripts/loop-until-started.ps1
