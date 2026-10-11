#!/bin/bash
# This is used to update the installers for an existing student workshop environment

echo "Downloading latest installer..."
wget https://global-package.dm.informaticacloud.com/package-manager/files/binary/informatica_cdi-pc_server_installer_linux64_202610/54000061/linux64/informatica_cdi-pc_server_installer_linux64_202610.54000061.tar

export WS_SERVER=cdipc-workshop-app0-1

echo "Patching {$WS_SERVER}..."

echo "Cleaning up the old installer..."
sudo docker exec -it $WS_SERVER rm -rf /apps/infa/cdipc/*

echo "Copying and unpacking the new installer..."
sudo docker cp informatica_cdi-pc_server_installer_linux64_202610.54000061.tar $WS_SERVER:/apps/infa/cdipc/informatica_cdi-pc_server_installer_linux64.tar
sudo docker exec -it $WS_SERVER tar -xvf /apps/infa/cdipc/informatica_cdi-pc_server_installer_linux64.tar
sudo docker cp /apps/cdipc-workshop/shared/config/SilentInputMigrate.properties $WS_SERVER:/apps/infa/cdipc/SilentInput.properties

echo "Deleting conflicting 10.5.9 binaries..."
sudo docker exec $WS_SERVER bash -c 'rm -f /apps/infa/cdipc/pluginjars/plugins/acplugins/*10.5.9*'
sudo docker exec $WS_SERVER bash -c 'rm -f /apps/infa/cdipc/pluginjars/plugins/dynamic/*10.5.9*'

echo "Cleaning up files and permissions..."
sudo docker exec -it $WS_SERVER rm -f /apps/infa/cdipc/informatica_cdi-pc_server_installer_linux64.tar
sudo docker exec -it $WS_SERVER chown -R root /apps/infa/cdipc
sudo docker exec -it $WS_SERVER chmod -R 755 /apps/infa/cdipc



export WS_SERVER=cdipc-workshop-app1-1

echo "Patching {$WS_SERVER}..."

echo "Cleaning up the old installer..."
sudo docker exec -it $WS_SERVER rm -rf /apps/infa/cdipc/*

echo "Copying and unpacking the new installer..."
sudo docker cp informatica_cdi-pc_server_installer_linux64_202610.54000061.tar $WS_SERVER:/apps/infa/cdipc/informatica_cdi-pc_server_installer_linux64.tar
sudo docker exec -it $WS_SERVER tar -xvf /apps/infa/cdipc/informatica_cdi-pc_server_installer_linux64.tar
sudo docker cp /apps/cdipc-workshop/shared/config/SilentInputMigrate.properties $WS_SERVER:/apps/infa/cdipc/SilentInput.properties

echo "Deleting conflicting 10.5.9 binaries..."
sudo docker exec $WS_SERVER bash -c 'rm -f /apps/infa/cdipc/pluginjars/plugins/acplugins/*10.5.9*'
sudo docker exec $WS_SERVER bash -c 'rm -f /apps/infa/cdipc/pluginjars/plugins/dynamic/*10.5.9*'

echo "Cleaning up files and permissions..."
sudo docker exec -it $WS_SERVER rm -f /apps/infa/cdipc/informatica_cdi-pc_server_installer_linux64.tar
sudo docker exec -it $WS_SERVER chown -R root /apps/infa/cdipc
sudo docker exec -it $WS_SERVER chmod -R 755 /apps/infa/cdipc



export WS_SERVER=cdipc-workshop-app2-1

echo "Patching {$WS_SERVER}..."

echo "Cleaning up the old installer..."
sudo docker exec -it $WS_SERVER rm -rf /apps/infa/cdipc/*

echo "Copying and unpacking the new installer..."
sudo docker cp informatica_cdi-pc_server_installer_linux64_202610.54000061.tar $WS_SERVER:/apps/infa/cdipc/informatica_cdi-pc_server_installer_linux64.tar
sudo docker exec -it $WS_SERVER tar -xvf /apps/infa/cdipc/informatica_cdi-pc_server_installer_linux64.tar
sudo docker cp /apps/cdipc-workshop/shared/config/SilentInputMigrate.properties $WS_SERVER:/apps/infa/cdipc/SilentInput.properties

echo "Deleting conflicting 10.5.9 binaries..."
sudo docker exec $WS_SERVER bash -c 'rm -f /apps/infa/cdipc/pluginjars/plugins/acplugins/*10.5.9*'
sudo docker exec $WS_SERVER bash -c 'rm -f /apps/infa/cdipc/pluginjars/plugins/dynamic/*10.5.9*'

echo "Cleaning up files and permissions..."
sudo docker exec -it $WS_SERVER rm -f /apps/infa/cdipc/informatica_cdi-pc_server_installer_linux64.tar
sudo docker exec -it $WS_SERVER chown -R root /apps/infa/cdipc
sudo docker exec -it $WS_SERVER chmod -R 755 /apps/infa/cdipc



export WS_SERVER=cdipc-workshop-app3-1

echo "Patching {$WS_SERVER}..."

echo "Cleaning up the old installer..."
sudo docker exec -it $WS_SERVER rm -rf /apps/infa/cdipc/*

echo "Copying and unpacking the new installer..."
sudo docker cp informatica_cdi-pc_server_installer_linux64_202610.54000061.tar $WS_SERVER:/apps/infa/cdipc/informatica_cdi-pc_server_installer_linux64.tar
sudo docker exec -it $WS_SERVER tar -xvf /apps/infa/cdipc/informatica_cdi-pc_server_installer_linux64.tar
sudo docker cp /apps/cdipc-workshop/shared/config/SilentInputMigrate.properties $WS_SERVER:/apps/infa/cdipc/SilentInput.properties

echo "Deleting conflicting 10.5.9 binaries..."
sudo docker exec $WS_SERVER bash -c 'rm -f /apps/infa/cdipc/pluginjars/plugins/acplugins/*10.5.9*'
sudo docker exec $WS_SERVER bash -c 'rm -f /apps/infa/cdipc/pluginjars/plugins/dynamic/*10.5.9*'

echo "Cleaning up files and permissions..."
sudo docker exec -it $WS_SERVER rm -f /apps/infa/cdipc/informatica_cdi-pc_server_installer_linux64.tar
sudo docker exec -it $WS_SERVER chown -R root /apps/infa/cdipc
sudo docker exec -it $WS_SERVER chmod -R 755 /apps/infa/cdipc



export WS_SERVER=cdipc-workshop-app4-1

echo "Patching {$WS_SERVER}..."

echo "Cleaning up the old installer..."
sudo docker exec -it $WS_SERVER rm -rf /apps/infa/cdipc/*

echo "Copying and unpacking the new installer..."
sudo docker cp informatica_cdi-pc_server_installer_linux64_202610.54000061.tar $WS_SERVER:/apps/infa/cdipc/informatica_cdi-pc_server_installer_linux64.tar
sudo docker exec -it $WS_SERVER tar -xvf /apps/infa/cdipc/informatica_cdi-pc_server_installer_linux64.tar
sudo docker cp /apps/cdipc-workshop/shared/config/SilentInputMigrate.properties $WS_SERVER:/apps/infa/cdipc/SilentInput.properties

echo "Deleting conflicting 10.5.9 binaries..."
sudo docker exec $WS_SERVER bash -c 'rm -f /apps/infa/cdipc/pluginjars/plugins/acplugins/*10.5.9*'
sudo docker exec $WS_SERVER bash -c 'rm -f /apps/infa/cdipc/pluginjars/plugins/dynamic/*10.5.9*'

echo "Cleaning up files and permissions..."
sudo docker exec -it $WS_SERVER rm -f /apps/infa/cdipc/informatica_cdi-pc_server_installer_linux64.tar
sudo docker exec -it $WS_SERVER chown -R root /apps/infa/cdipc
sudo docker exec -it $WS_SERVER chmod -R 755 /apps/infa/cdipc



export WS_SERVER=cdipc-workshop-app5-1

echo "Patching {$WS_SERVER}..."

echo "Cleaning up the old installer..."
sudo docker exec -it $WS_SERVER rm -rf /apps/infa/cdipc/*

echo "Copying and unpacking the new installer..."
sudo docker cp informatica_cdi-pc_server_installer_linux64_202610.54000061.tar $WS_SERVER:/apps/infa/cdipc/informatica_cdi-pc_server_installer_linux64.tar
sudo docker exec -it $WS_SERVER tar -xvf /apps/infa/cdipc/informatica_cdi-pc_server_installer_linux64.tar
sudo docker cp /apps/cdipc-workshop/shared/config/SilentInputMigrate.properties $WS_SERVER:/apps/infa/cdipc/SilentInput.properties

echo "Deleting conflicting 10.5.9 binaries..."
sudo docker exec $WS_SERVER bash -c 'rm -f /apps/infa/cdipc/pluginjars/plugins/acplugins/*10.5.9*'
sudo docker exec $WS_SERVER bash -c 'rm -f /apps/infa/cdipc/pluginjars/plugins/dynamic/*10.5.9*'

echo "Cleaning up files and permissions..."
sudo docker exec -it $WS_SERVER rm -f /apps/infa/cdipc/informatica_cdi-pc_server_installer_linux64.tar
sudo docker exec -it $WS_SERVER chown -R root /apps/infa/cdipc
sudo docker exec -it $WS_SERVER chmod -R 755 /apps/infa/cdipc



export WS_SERVER=cdipc-workshop-app6-1

echo "Patching {$WS_SERVER}..."

echo "Cleaning up the old installer..."
sudo docker exec -it $WS_SERVER rm -rf /apps/infa/cdipc/*

echo "Copying and unpacking the new installer..."
sudo docker cp informatica_cdi-pc_server_installer_linux64_202610.54000061.tar $WS_SERVER:/apps/infa/cdipc/informatica_cdi-pc_server_installer_linux64.tar
sudo docker exec -it $WS_SERVER tar -xvf /apps/infa/cdipc/informatica_cdi-pc_server_installer_linux64.tar
sudo docker cp /apps/cdipc-workshop/shared/config/SilentInputMigrate.properties $WS_SERVER:/apps/infa/cdipc/SilentInput.properties

echo "Deleting conflicting 10.5.9 binaries..."
sudo docker exec $WS_SERVER bash -c 'rm -f /apps/infa/cdipc/pluginjars/plugins/acplugins/*10.5.9*'
sudo docker exec $WS_SERVER bash -c 'rm -f /apps/infa/cdipc/pluginjars/plugins/dynamic/*10.5.9*'

echo "Cleaning up files and permissions..."
sudo docker exec -it $WS_SERVER rm -f /apps/infa/cdipc/informatica_cdi-pc_server_installer_linux64.tar
sudo docker exec -it $WS_SERVER chown -R root /apps/infa/cdipc
sudo docker exec -it $WS_SERVER chmod -R 755 /apps/infa/cdipc

echo "Finished!"