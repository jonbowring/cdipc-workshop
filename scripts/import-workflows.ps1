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

# Loop through the environments and reset them
foreach($obj in $envs) {
    
    # Copy the files into the container
    Write-Output "`nTransferring workflow files for $($obj.name)..."
    ssh -i "CDI-PC-Workshop.pem" ec2-user@CDI-PC-Workshop-Server-1 "sudo docker cp /tmp/ws_import cdipc-workshop-$($obj.app)-1:/tmp"
	
    # Make the import script executable
	Write-Output "Making script executable for $($obj.name)..."
	ssh -i "CDI-PC-Workshop.pem" ec2-user@CDI-PC-Workshop-Server-1 "sudo docker exec cdipc-workshop-$($obj.app)-1 chmod +x /tmp/ws_import/import.sh"

    # Run the import script
	ssh -i "CDI-PC-Workshop.pem" ec2-user@CDI-PC-Workshop-Server-1 "sudo docker exec cdipc-workshop-$($obj.app)-1 /tmp/ws_import/import.sh"
	
}

Write-Output "Done!"