## Prerequisites

### 1. Install Docker Desktop for Windows

1. Download [Docker Desktop](https://www.docker.com/products/docker-desktop/)
2. Run the installer
3. Enable the following during installation:
   - **Hyper-V Windows Features**
   - **Windows Subsystem for Linux (WSL 2)** - optional, but recommended

### 2. Enable Windows Containers Mode

Docker Desktop defaults to Linux containers. Switch to Windows containers:

**Option A: Using Docker Desktop UI**
- Right-click Docker Desktop system tray icon
- Select "Switch to Windows containers..."

**Option B: Using Command Line**
```powershell
# Switch to Windows containers
docker desktop engine use windows

# Verify you're in Windows mode
docker info | Select-String OSType
# Should output: OSType: windows
```

### 3. Configure Docker Builder

Ensure Docker is using the Windows builder:
```powershell
docker buildx use desktop-windows
```

### 4. Verify Hyper-V

Check that Hyper-V is enabled:
```powershell
# Check Hyper-V status
Get-WindowsOptionalFeature -FeatureName Microsoft-Hyper-V-All -Online

# Should show: State : Enabled
```

If not enabled, run as Administrator:
```powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
# Restart required
```

## Showtime

### Prep it

```ps1
.\01-init-dockerfile.ps1
.\02-copy-web-content.ps1
```

### Build it

```ps1
docker build -t brightmetrics-web:latest .
```

### Run it

```ps1
docker run -d --name brightmetrics-web --isolation=hyperv -p 8080:80 brightmetrics-web:latest
```

### Stop/Start it

```ps1
docker stop brightmetrics-web
docker rm brightmetrics-web
docker ps
```

### Wait for it to start completely

```ps1
./misc/loop-until-started.ps1
```

### Modify it while running

```ps1
docker exec brightmetrics-web powershell -Command "Write-Host hello"
```
