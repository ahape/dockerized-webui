FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2022

WORKDIR /inetpub/wwwroot

COPY scripts/container/* docker-build/ ./

RUN powershell -ExecutionPolicy Bypass -File ./install-tools.ps1 && \
    powershell -ExecutionPolicy Bypass -File ./set-env-vars.ps1 && \
    powershell -ExecutionPolicy Bypass -File ./configure.ps1

EXPOSE 8008

HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
    CMD powershell -ExecutionPolicy Bypass -File ./health-check.ps1
