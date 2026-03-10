@"
[Environment]::SetEnvironmentVariable('AZURE_CLIENT_ID',      '$env:AZURE_CLIENT_ID',       'Machine');
[Environment]::SetEnvironmentVariable('AZURE_CLIENT_SECRET',  '$env:AZURE_CLIENT_SECRET',   'Machine');
[Environment]::SetEnvironmentVariable('AZURE_TENANT_ID',      '$env:AZURE_TENANT_ID',       'Machine');
[Environment]::SetEnvironmentVariable('AzureWebJobsDashboard','DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint=http://host.docker.internal:10000/devstoreaccount1;QueueEndpoint=http://host.docker.internal:10001/devstoreaccount1;TableEndpoint=http://host.docker.internal:10002/devstoreaccount1;', 'Machine');
[Environment]::SetEnvironmentVariable('AzureWebJobsEnv',      'Development',                'Machine');
[Environment]::SetEnvironmentVariable('AzureWebJobsStorage',  'DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint=http://host.docker.internal:10000/devstoreaccount1;QueueEndpoint=http://host.docker.internal:10001/devstoreaccount1;TableEndpoint=http://host.docker.internal:10002/devstoreaccount1;', 'Machine');
"@ > ./scripts/container/set-env-vars.ps1
