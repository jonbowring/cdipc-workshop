# CDI-PC Lab Environment

## Overview
This document provides a basic outline for using and understanding the CDI-PC Lab Environment application. This setup is designed to simplify multi-container Docker applications.

## Prerequisites
- Ensure that Docker and Docker Compose are installed on your machine.
- Familiarity with Docker concepts and commands is helpful.

## Setup Instructions

### Step 1: Add an entry to your hosts file for the cdipcapp server
Clone this repository to your local machine using the following command:

<Public IP Address> cdipcapp

### Step 2: Navigate to the Project Directory
Clone this repository to your local machine using the following command:

cd /apps/cdipc-lab

### Step 3: Build and Start the Containers
Use Docker Compose to build and start all the containers defined in the `docker-compose.yml` file:

sudo docker compose up --build --detach

### Step 4: Access the Application
It will take ~15 mins to install PowerCenter when the container is created. Once the application is running, you can access the administrator console using the following URL:

https://cdipcapp:8443/administrator/

### Step 5: Remote into the container
Use the below command to remote into the container:

sudo docker exec -it cdipc-lab-cdipcapp-1 /bin/bash

### Step 6: Change into the CDI-PC installation directory
Use the below command to change to the CDI-PC installation directory:

cd /apps/infa/cdipc

### Step 7: Extract the CDI-PC installation files
Use the below command to extract the CDI-PC installation files:

tar -xvf informatica_cdi-pc_server_installer_linux64.tar

### Step 8: Run the installer
Use the below command to install CDI-PC:
    - PowerCenter install directory = /apps/infa/105
    - CDI-PC install directory = /apps/infa/cdipc
    - User = Administrator
    - Password = infa

./install.sh

### Step 9: Change to the idmc user
Before installing the secure agent change to the idmc user with the below command:

su idmc

### Step 10: Change into the secure agent installation directory
Use the below command to change to the secure agent installation directory:

cd /apps/infa/idmc

### Step 11: Run the installer
Use the below command to install the secure agent:
    - Install directory = /apps/infa/idmc

./agent64_install_ng_ext.bin -i console

### Step 12: Change directory and start the secure agent
Use the below commands to start the secure agent

cd /apps/infa/idmc/apps/agentcore
./infaagent.sh startup

### Step 13: Login to IDMC
Use the below command to start register the secure agent

./consoleAgentManager.sh configureToken <user name> <install token>

### Step 14: Enable the secure agent services
Enable the below services needed for CDI-PC on the secure agent group:

- Data Integration
- Domain Management App
- Cloud Data Validation
- PC2CDIModernizationApp

### Step 15: Configure trust properties
Configure the following secure agent trust settings on the "Domain Management App" of the secure agent:

- DMA_DOMAINS_COMM_KEYSTORE = /apps/infa/keys/infa_keystore.jks
- DMA_DOMAINS_COMM_KEYSTORE_PASS = changeit
- DMA_DOMAINS_COMM_TRUSTSTORE = /apps/infa/keys/infa_truststore.jks
- DMA_DOMAINS_COMM_TRUSTSTORE_PASS = changeit

### Step 16: Register the domain
In IDMC, register the domain using the below settings:

- Host = cdipcapp
- Port = 6005
- Domain Name = DomainName
- Security Domain = Native
- User = Administrator
- Password = infa

### Step 17: Assess the repository
In IDMC, assess the repository using the below settings:

- Security Domain = Native
- User = Administrator
- Password = infa
- Shared Directory = /tmp

### Step 18: Run the conversion
In IDMC, convert the workflows using the below settings:

- Security Domain = Native
- User = Administrator
- Password = infa
- Shared Directory = /tmp

## Configuration
- All configuration options can be adjusted in the `docker-compose.yml` file.
- Environment variables can be set in a `.env` file in the project root.

## Services
Describe the different services running in your application:

- **Service 1**: Description of what service 1 does.
- **Service 2**: Description of what service 2 does.
 
## Useful Commands
- **Start Containers**: `sudo docker compose up`
- **Stop Containers**: `sudo docker compose down`
- **View Logs**: `sudo docker compose logs`
- **Rebuild Containers**: `sudo docker compose build`

## Troubleshooting
- If you encounter issues during the setup or runtime, check the logs using `docker-compose logs`.
- Ensure port mappings in `docker-compose.yml` are correctly configured and not conflicting with existing services on your machine.

## Authors
- Jonathon Bowring

