#!/bin/bash

# Start the OpenSSH server
/usr/sbin/sshd

# Start PowerCenter
/apps/infa/105/tomcat/bin/infaservice.sh startup

# Keep the container running
echo "Starting...." &
tail -f /dev/null
