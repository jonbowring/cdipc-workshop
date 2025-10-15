#!/bin/bash

# Connect to the repository
echo "Connecting to the repository..."
export INFA_HOME="/apps/infa/105"
/apps/infa/105/server/bin/pmrep connect -r PCRS_DEV -d Domain_cdipc -n Administrator -x infa -s Native

# Create the folders
echo "Creating the folders..."
/apps/infa/105/server/bin/pmrep createfolder -n SHAREFOLDER -s
/apps/infa/105/server/bin/pmrep createfolder -n Internal_Apps
/apps/infa/105/server/bin/pmrep createfolder -n "Rekening Koran"
/apps/infa/105/server/bin/pmrep createfolder -n Treasury
/apps/infa/105/server/bin/pmrep createfolder -n Log
/apps/infa/105/server/bin/pmrep createfolder -n CAMS

# Import the workflows
echo "Importing the workflows..."
/apps/infa/105/server/bin/pmrep objectimport -i /tmp/ws_import/wf_Dly_CTM.XML -c /tmp/ws_import/pc_ctrl_wf_Dly_CTM.XML
/apps/infa/105/server/bin/pmrep objectimport -i /tmp/ws_import/wf_Dly_Electricity_ID.XML -c /tmp/ws_import/pc_ctrl_wf_Dly_Electricity_ID.XML
/apps/infa/105/server/bin/pmrep objectimport -i /tmp/ws_import/wf_Dly_Treasury_DCI.XML -c /tmp/ws_import/pc_ctrl_wf_Dly_Treasury_DCI.XML
/apps/infa/105/server/bin/pmrep objectimport -i /tmp/ws_import/wf_Dly_Treasury_SLD.XML -c /tmp/ws_import/pc_ctrl_wf_Dly_Treasury_SLD.XML
/apps/infa/105/server/bin/pmrep objectimport -i /tmp/ws_import/wf_Mthly_Cams_Extract_Claim_BG.XML -c /tmp/ws_import/pc_ctrl_wf_Mthly_Cams_Extract_Claim_BG.XML
/apps/infa/105/server/bin/pmrep objectimport -i /tmp/ws_import/wf_Mthly_Rekening_Koran.XML -c /tmp/ws_import/pc_ctrl_wf_Mthly_Rekening_Koran.XML
/apps/infa/105/server/bin/pmrep objectimport -i /tmp/ws_import/wf_Mthly_Survey_Gallup.XML -c /tmp/ws_import/pc_ctrl_wf_Mthly_Survey_Gallup.XML
