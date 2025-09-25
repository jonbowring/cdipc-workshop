Write-Output "`nResetting students 1 to 6...."
ssh -i "CDI-PC-Workshop.pem" ec2-user@CDI-PC-Workshop-Server-1 "cd /apps/cdipc-workshop; sudo docker compose down; sudo docker system prune -f; sudo docker compose up --detach"

Write-Output "`nResetting students 7 to 12...."
ssh -i "CDI-PC-Workshop.pem" ec2-user@CDI-PC-Workshop-Server-2 "cd /apps/cdipc-workshop; sudo docker compose down; sudo docker system prune -f; sudo docker compose up --detach"

Write-Output "`nResetting students 13 to 18...."
ssh -i "CDI-PC-Workshop.pem" ec2-user@CDI-PC-Workshop-Server-3 "cd /apps/cdipc-workshop; sudo docker compose down; sudo docker system prune -f; sudo docker compose up --detach"

Write-Output "`nResetting students 19 to 24...."
ssh -i "CDI-PC-Workshop.pem" ec2-user@CDI-PC-Workshop-Server-4 "cd /apps/cdipc-workshop; sudo docker compose down; sudo docker system prune -f; sudo docker compose up --detach"

Write-Output "`nResetting students 25 to 30...."
ssh -i "CDI-PC-Workshop.pem" ec2-user@CDI-PC-Workshop-Server-5 "cd /apps/cdipc-workshop; sudo docker compose down; sudo docker system prune -f; sudo docker compose up --detach"