#!/bin/bash

# Start the OpenSSH server
/usr/sbin/sshd

# Install PowerCenter
/apps/infa/105/silentinstall.sh
echo "Installation complete!"

# Connect to the repository
echo "Connecting to the repository..."
export INFA_HOME="/apps/infa/105"
/apps/infa/105/server/bin/pmrep connect -r PCRS_DEV -d DomainName -n Administrator -x infa -s Native

# Create the repository folders
echo "Creating the repository folders..."
/apps/infa/105/server/bin/pmrep createfolder -n Load_Dim_Tables
/apps/infa/105/server/bin/pmrep createfolder -n Load_Fact_Tables
/apps/infa/105/server/bin/pmrep createfolder -n Stage_Tables

# Import the repository objects
echo "Importing the repository objects..."
/apps/infa/105/server/bin/pmrep objectimport -i /apps/infa/shared/config/Load_Dim_Tables.XML -c /apps/infa/shared/config/pc_import_control_file_Dim.xml
/apps/infa/105/server/bin/pmrep objectimport -i /apps/infa/shared/config/Load_Fact_Tables.XML -c /apps/infa/shared/config/pc_import_control_file_Fact.xml
/apps/infa/105/server/bin/pmrep objectimport -i /apps/infa/shared/config/Stage_Tables.XML -c /apps/infa/shared/config/pc_import_control_file_Stage.xml

# Keep the container running
echo "Done!" &
tail -f /dev/null
