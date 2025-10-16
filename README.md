### Build it

```ps1
docker build -t brightmetrics-web:latest .
```

### Run it

```ps1
docker run -d --name brightmetrics-web --isolation=hyperv -p 8080:80 brightmetrics-web:latest
```

### Wait for it to start completely

```ps1
do {
  $status = docker inspect --format='{{.State.Health.Status}}' brightmetrics-web
  Start-Sleep -Seconds 3
} while ($status -eq "starting")
docker inspect --format='{{.State.Health.Status}}' brightmetrics-web
```

### Talk to it

```ps1
docker exec brightmetrics-web powershell -Command "Write-Host hello"
```
