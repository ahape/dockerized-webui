FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2022

WORKDIR /inetpub/wwwroot

# Install Chocolatey and required software
RUN powershell -Command \
    Set-ExecutionPolicy Bypass -Scope Process -Force; \
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')); \
    choco install -y vim urlrewrite

# Set all Azure environment variables at MACHINE level (including secret)
RUN powershell -Command \
    [Environment]::SetEnvironmentVariable('AZURE_CLIENT_ID',      '%AZURE_CLIENT_ID%',          'Machine'); \
    [Environment]::SetEnvironmentVariable('AZURE_CLIENT_SECRET',  '%AZURE_CLIENT_SECRET%',      'Machine'); \
    [Environment]::SetEnvironmentVariable('AZURE_TENANT_ID',      '%AZURE_TENANT_ID%',          'Machine'); \
    [Environment]::SetEnvironmentVariable('AzureWebJobsDashboard','UseDevelopmentStorage=true', 'Machine'); \
    [Environment]::SetEnvironmentVariable('AzureWebJobsEnv',      'Development',                'Machine'); \
    [Environment]::SetEnvironmentVariable('AzureWebJobsStorage',  'UseDevelopmentStorage=true', 'Machine')

RUN powershell -Command \
    Remove-Website -Name 'Default Web Site'

COPY docker-build/ .

RUN powershell -Command \
    Import-Module WebAdministration; \
    New-WebAppPool -Name 'BrightMetricsPool'; \
    Set-ItemProperty IIS:\AppPools\BrightMetricsPool -Name managedRuntimeVersion -Value 'v4.0'; \
    Set-ItemProperty IIS:\AppPools\BrightMetricsPool -Name enable32BitAppOnWin64 -Value $false; \
    New-Website -Name 'BrightMetrics' -Port 80 -PhysicalPath C:\inetpub\wwwroot -ApplicationPool 'BrightMetricsPool'; \
    $acl = Get-Acl C:\inetpub\wwwroot; \
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule('IIS_IUSRS', 'FullControl', 'ContainerInherit,ObjectInherit', 'None', 'Allow'); \
    $acl.SetAccessRule($rule); \
    Set-Acl C:\inetpub\wwwroot $acl

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
    CMD powershell -command \
    try { \
        $response = Invoke-WebRequest http://localhost/ServiceCheck.aspx -UseBasicParsing; \
        if ($response.StatusCode -eq 200) { return 0 } else { return 1 } \
    } catch { return 1 }
