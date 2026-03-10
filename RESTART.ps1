param([switch]$NoCopy = $false)

if (-not $NoCopy) {
  ./scripts/copy-web-content.ps1
}

docker compose up -d --build

./scripts/loop-until-started.ps1
