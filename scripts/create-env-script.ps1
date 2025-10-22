@"
[Environment]::SetEnvironmentVariable('AZURE_CLIENT_ID',      '$env:AZURE_CLIENT_ID',       'Machine');
[Environment]::SetEnvironmentVariable('AZURE_CLIENT_SECRET',  '$env:AZURE_CLIENT_SECRET',   'Machine');
[Environment]::SetEnvironmentVariable('AZURE_TENANT_ID',      '$env:AZURE_TENANT_ID',       'Machine');
[Environment]::SetEnvironmentVariable('AzureWebJobsDashboard','UseDevelopmentStorage=true', 'Machine');
[Environment]::SetEnvironmentVariable('AzureWebJobsEnv',      'Development',                'Machine');
[Environment]::SetEnvironmentVariable('AzureWebJobsStorage',  'UseDevelopmentStorage=true', 'Machine');
"@ > ./scripts/container/set-env-vars.ps1
