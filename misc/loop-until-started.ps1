do {
  $status = docker inspect --format='{{.State.Health.Status}}' brightmetrics-web
  Start-Sleep -Seconds 3
} while ($status -eq "starting")
docker inspect --format='{{.State.Health.Status}}' brightmetrics-web
