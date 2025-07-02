#!/bin/bash

# Start the OpenSSH server
/usr/sbin/sshd

# Start PowerCenter
/apps/infa/105/isp/bin/infasetup.sh generateEncryptionKey -kl /apps/infa/105/isp/config/keys
/apps/infa/105/isp/bin/infasetup.sh migrateEncryptionKey -loc /apps/infa/105/isp/config/keys
/apps/infa/105/tomcat/bin/infaservice.sh startup

# Keep the container running
echo "Starting...." &
tail -f /dev/null
