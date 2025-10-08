param (
	[int]$From = 0,
	[int]$To = 30
)

# Read the environments json file
$json = Get-Content -Raw -Path "environments.json"
$envs = $json | ConvertFrom-Json
$envs = $envs[$From..$To]

# Define connection parameters
$User = "root"
$Password = "root"

# Convert password to a secure string
$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force

# Create a PSCredential object
$Credential = New-Object System.Management.Automation.PSCredential($User, $SecurePassword)

# Loop through the environments and test them
foreach($obj in $envs) {
	
	Write-Output "`nSmoke testing $($obj.name)..."
	$Session = New-SSHSession -ComputerName $obj.host -Credential $Credential -Port $obj.sshPort
	
	# Test the database availability
	$Result = Test-NetConnection -ComputerName $obj.host -Port $obj.dbPort
	$Passed = $Result | Select-Object -Property "TcpTestSucceeded"
	if($Passed) {
		Write-Output "Database.... [PASS]"
	} else {
		Write-Output "Database.... [FAILED]"
	}
	
	# Test the ssh server availability
	$Result = Test-NetConnection -ComputerName $obj.host -Port $obj.sshPort
	$Passed = $Result | Select-Object -Property "TcpTestSucceeded"
	if($Passed) {
		Write-Output "SSH Server.... [PASS]"
	} else {
		Write-Output "SSH Server.... [FAILED]"
	}
	
	# Test the admin console availability
	$Result = Test-NetConnection -ComputerName $obj.host -Port $obj.adminPort
	$Passed = $Result | Select-Object -Property "TcpTestSucceeded"
	if($Passed) {
		Write-Output "PowerCenter Administration Console.... [PASS]"
	} else {
		Write-Output "PowerCenter Administration Console.... [FAILED]"
	}
	
	# Test the repository service
	$Command = 'source /root/.bash_profile; /apps/infa/105/server/bin/infacmd.sh ping -dn "Domain_cdipc" -dg "cdipcapp:6005" -sn "PCRS_DEV" -nn "NodeName"'
	$Result = Invoke-SSHCommand -SSHSession $Session -Command $Command | Select-Object -ExpandProperty Output
	if($Result -match "was successfully pinged") {
		Write-Output "PowerCenter Repository Service.... [PASS]"
	} else {
		Write-Output "PowerCenter Repository Service.... [FAILED]"
	}
	
	# Test the integration service
	$Command = 'source /root/.bash_profile; /apps/infa/105/server/bin/infacmd.sh ping -dn "Domain_cdipc" -dg "cdipcapp:6005" -sn "PCIS_DEV" -nn "NodeName"'
	$Result = Invoke-SSHCommand -SSHSession $Session -Command $Command | Select-Object -ExpandProperty Output
	if($Result -match "was successfully pinged") {
		Write-Output "PowerCenter Integration Service.... [PASS]"
	} else {
		Write-Output "PowerCenter Integration Service.... [FAILED]"
	}
	
	# Close the session
	$Closed = Remove-SSHSession -SSHSession $Session
}