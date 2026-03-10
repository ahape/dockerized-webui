## Prerequisites

### 1. Install Docker Desktop for Windows

1. Download [Docker Desktop](https://www.docker.com/products/docker-desktop/)
2. Run the installer
3. Enable the following during installation:
   - **Hyper-V Windows Features**
   - **Windows Subsystem for Linux (WSL 2)** - optional, but not needed for this

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
.\scripts\create-env-script.ps1
```

That imports your environment variables (AZURE_\*) needed to run WebUI. They're
saved to the file `scripts/container/set-env-vars.ps1`. That file isn't
included in the repo because it has the secret `AZURE_CLIENT_SECRET`.

```ps1
.\scripts\copy-web-content.ps1
```

That copies over the stuff from `/src/azure/BrightmetricsWeb` into this repo
folder. This stages it for when we build the docker image, since it can't really
run `COPY` to files outside the docker root folder.

### Architecture

`docker compose up` starts two containers:

| Service | Purpose | Access |
|---------|---------|--------|
| **web** | ASP.NET app (IIS) | `localhost:8008` |
| **azurite** | Azure Storage emulator | `127.0.0.1:10000-10002` from inside the web container |

Azurite shares the web container's network (`network_mode: "service:web"`), so the
app can reach it at `127.0.0.1` just like `UseDevelopmentStorage=true` expects.

### Build + start

```ps1
docker compose up -d --build
```

Or use the all-in-one restart script (copies content, builds, starts, waits for healthy):

```ps1
.\RESTART.ps1
```

### Stop

```ps1
docker compose down
```

### Wait for it to start completely

```ps1
.\scripts\loop-until-started.ps1
```

### Modify it while running

```ps1
docker exec brightmetrics-web powershell -Command "Write-Host hello"
```
