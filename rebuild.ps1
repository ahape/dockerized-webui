# Define paths
$SourcePath = "C:\src\azure\BrightMetricsWeb"
$DestPath   = ".\docker-build"

# Clean up old destination if it exists
if (Test-Path $DestPath) {
    Write-Host "Removing existing directory: $DestPath"
    Remove-Item -Recurse -Force $DestPath
}

# Recreate destination
Write-Host "Creating directory: $DestPath"
New-Item -ItemType Directory -Path $DestPath | Out-Null

# Copy files
Write-Host "Copying files from $SourcePath to $DestPath..."
Copy-Item -Recurse -Force -Path (Join-Path $SourcePath '*') -Destination $DestPath

# Build Docker image
Write-Host "Building Docker image: brightmetrics-web"
docker build -t brightmetrics-web .
