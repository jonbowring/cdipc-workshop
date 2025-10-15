param (
	[int]$From = 0,
	[int]$To = 30
)

# Clear the known hosts file
Clear-Content -Path "C:\Users\Administrator\.ssh\known_hosts"

# Read the environments json file
$json = Get-Content -Raw -Path "environments.json"
$envs = $json | ConvertFrom-Json
$envs = $envs[$From..$To]

# Define connection parameters
$User = "root"
$Password = "root"
$Command = "source /root/.bash_profile; cd /apps/infa/105/tomcat/bin; ./infaservice.sh startup"

# Convert password to a secure string
$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force

# Create a PSCredential object
$Credential = New-Object System.Management.Automation.PSCredential($User, $SecurePassword)

# Loop through the environments and reset them
foreach($obj in $envs) {
	Write-Output "`nResetting $($obj.name)..."
	ssh -i "CDI-PC-Workshop.pem" "ec2-user@$($obj.host)" "cd /apps/cdipc-workshop; sudo docker compose stop $($obj.app); sudo docker compose stop $($obj.db); sudo docker compose down $($obj.app); sudo docker system prune -f; sudo docker compose up --detach $($obj.app)"
	Write-Output "Waiting for database to start..."
	Start-Sleep -Seconds 5
	
	Write-Output "Starting PowerCenter for $($obj.name)..."
	$Session = New-SSHSession -ComputerName $obj.host -Credential $Credential -Port $obj.sshPort
	Invoke-SSHCommand -SSHSession $Session -Command $Command | Select-Object -ExpandProperty Output
	Remove-SSHSession -SSHSession $Session
}