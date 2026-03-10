FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Ensure powershell is the default shell for the build steps
SHELL ["powershell", "-Command", "$ErrorActionPreference='Stop';"]

# Download and extract Node.js, then set the system PATH properly
RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
  Invoke-WebRequest -Uri 'https://nodejs.org/dist/v20.18.3/node-v20.18.3-win-x64.zip' -OutFile C:\node.zip; \
  Expand-Archive C:\node.zip -DestinationPath C:\; \
  Rename-Item 'C:\node-v20.18.3-win-x64' 'C:\nodejs'; \
  Remove-Item C:\node.zip; \
  [Environment]::SetEnvironmentVariable('PATH', 'C:\nodejs;' + $env:PATH, [EnvironmentVariableTarget]::Machine)

# Install Azurite LOCALLY in a specific folder to avoid AppData/Global PATH headaches
WORKDIR C:\azurite
RUN npm install azurite

# Create a dedicated directory for Azurite's data files
RUN New-Item -ItemType Directory -Path C:\data

EXPOSE 10000 10001 10002

# Use the generated .cmd wrapper instead of hardcoding the path to the .js file
ENTRYPOINT ["C:\\azurite\\node_modules\\.bin\\azurite.cmd", \
  "--blobHost", "0.0.0.0", "--queueHost", "0.0.0.0", "--tableHost", "0.0.0.0", \
  "--location", "C:\\data"]
