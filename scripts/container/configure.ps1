Import-Module WebAdministration;

$pool = 'BrightmetricsPool';
$wwwroot = 'C:\inetpub\wwwroot';

New-WebAppPool -Name $pool;

Set-ItemProperty -Path "IIS:\AppPools\$pool" -Name managedRuntimeVersion -Value 'v4.0';
Set-ItemProperty -Path "IIS:\AppPools\$pool" -Name enable32BitAppOnWin64 -Value $false;

New-Website -Name 'Brightmetrics' -Port 8008 -PhysicalPath $wwwroot -ApplicationPool $pool;

$acl = Get-Acl $wwwroot;
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule('IIS_IUSRS', 'FullControl', 'ContainerInherit,ObjectInherit', 'None', 'Allow');
$acl.SetAccessRule($rule);
Set-Acl $wwwroot $acl
