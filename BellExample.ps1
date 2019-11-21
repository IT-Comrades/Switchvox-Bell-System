[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$username = "admin"
$server = "xxx.xxx.xxx.xxx"
$securePass = Get-Content C:\Path\To\ScheduledTaskUser.txt | ConvertTo-SecureString
$creds = New-Object System.Management.Automation.PSCredential -ArgumentList $username,$securePass
Connect-SvxServer $server -Credential $creds
Invoke-SvoxCall -Extension {PA_EXTENSION} -AccountId {ACCOUNTID_FOR_ADMIN} -Number {EXTENSION_FOR_IVR} -CallerId "Bell"
Disconnect-SvxServer