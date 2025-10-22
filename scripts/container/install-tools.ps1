[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 0xC00;
[System.Net.WebClient]::new().DownloadString('https://community.chocolatey.org/install.ps1') | Invoke-Expression
# vim -- in case files need to be manually edited in the container (via `docker exec`)
# urlrewrite -- for custom IIS header rewrite rules (see Web.config)
choco install -y vim urlrewrite;
