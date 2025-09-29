# CDI-PC Lab Environment

## Overview
This document provides a basic outline for using and understanding the CDI-PC Lab Environment application. This setup is designed to simplify multi-container Docker applications.

## Release Notes

### 2025-07-01
- Updated CDI-PC installer from version 202410 to 202504

## Student Details
- Student 1:
    - Admin console: https://cdipcapp:9441/administrator/
    - SSH: ssh -p 221 root@cdipcapp
        - Note: Password is "root" 
- Student 2:
    - Admin console: https://cdipcapp:9442/administrator/
    - SSH: ssh -p 222 root@cdipcapp
        - Note: Password is "root"
- Student 3:
    - Admin console: https://cdipcapp:9443/administrator/
    - SSH: ssh -p 223 root@cdipcapp
        - Note: Password is "root"
- Student 4:
    - Admin console: https://cdipcapp:9444/administrator/
    - SSH: ssh -p 224 root@cdipcapp
        - Note: Password is "root"
- Student 5:
    - Admin console: https://cdipcapp:9445/administrator/
    - SSH: ssh -p 225 root@cdipcapp
        - Note: Password is "root"
- Student 6:
    - Admin console: https://cdipcapp:9446/administrator/
    - SSH: ssh -p 226 root@cdipcapp
        - Note: Password is "root"

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

## Step 1: Build the image
sudo docker build -t cdipc/build:latest .

### Step 2: Start the Containers
Use Docker Compose to build and start all the containers defined in the `docker-compose.yml` file:

sudo docker compose up --detach

### Take a backup of the siteKey

IMPORTANT!!!!!! Everytime you commit a new pre-built image, you need to ensure that the database backup is aligned with the image

Take a backup of the siteKey. For example:

sudo docker cp 72c6530e871c:/apps/infa/105/isp/config/keys/siteKey .

### Backup the database. For example:

sudo docker exec -it 6b7203e34773 /bin/bash
cd /tmp
pg_dumpall -h localhost -U infa --exclude-database=infa > postgres_backup.sql
exit
sudo docker cp 6b7203e34773:/tmp/postgres_backup.sql .

### Comment out the SQL statements for the infa database
For example:

--CREATE ROLE infa;
--ALTER ROLE infa WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:J3GakfSL+GcocBZvauhKVQ==$IjHy3JpuAmnZ6MsZh0oJpIw3gNdFUbhAWEw9NRa25fQ=:7Osz+tZ7ENnDiRIc/cG5b0bqa2QYTGFOidHWffzDgyM=';

### Commit the newly built app image
sudo docker commit 72c6530e871c cdipc/prebuilt:latest

------------------------------------------

### Step 3: Access the Application
It will take ~15 mins to install PowerCenter when the container is created. Once the application is running, you can access the administrator console using the following URL:

https://cdipcapp:9441/administrator/

### Step 4: Remote into the container
Use the below command to remote into the container:

ssh -p 221 root@cdipcapp

OR for instructors:

sudo docker exec -it cdipc-lab-cdipcapp-1 /bin/bash

### Step 5: Change into the CDI-PC installation directory
Use the below command to change to the CDI-PC installation directory:

cd /apps/infa/cdipc

### Step 6: Run the installer
Use the below command to install CDI-PC:
    - PowerCenter install directory = /apps/infa/105
    - CDI-PC install directory = /apps/infa/cdipc
    - User = Administrator
    - Password = infa

./install.sh

### Step 7: Change to the idmc user
Before installing the secure agent change to the idmc user with the below command:

su idmc

### Step 8: Change into the secure agent installation directory
Use the below command to change to the secure agent installation directory:

cd /apps/infa/idmc

### Step 9: Run the installer
Use the below command to install the secure agent:
    - Install directory = /apps/infa/idmc

./agent64_install_ng_ext.bin -i console

### Step 10: Change directory and start the secure agent
Use the below commands to start the secure agent

cd /apps/infa/idmc/apps/agentcore
./infaagent.sh startup

### Step 11: Login to IDMC
Use the below command to start register the secure agent

./consoleAgentManager.sh configureToken <user name> <install token>

### Step 12: Enable the secure agent services
Enable the below services and connections on the secure agent group:

- Services:
    - Data Integration
    - Domain Management App
    - Cloud Data Validation
    - PC2CDIModernizationApp
- Connections:
    - PostgreSQL

### Step 13: Configure trust properties
Configure the following secure agent trust settings on the "Domain Management App" of the secure agent:

- DMA_DOMAINS_COMM_KEYSTORE = /apps/infa/keys/infa_keystore.jks
- DMA_DOMAINS_COMM_KEYSTORE_PASS = changeit
- DMA_DOMAINS_COMM_TRUSTSTORE = /apps/infa/keys/infa_truststore.jks
- DMA_DOMAINS_COMM_TRUSTSTORE_PASS = changeit

### Step 14: Create the Data Validation connections
Create the following connections for use in Data Validation:

- Customer_PostgreSQL:
    - Name: Customer_PostgreSQL
    - Type: PostgreSQL
    - Runtime environment: cdipcapp
    - Authentication type: Database
    - Username: infa
    - Password: infa
    - Hostname: cdipcdb
    - Port: 5432
    - Database name: infa

- ff_CDV_Source:
    - Name: ff_CDV_Source
    - Type: Flat file
    - Runtime environment: cdipcapp
    - Directory: /apps/infa/shared/src
    - Date format: MM/dd/yyyy HH:mm:ss
    - Code page: UTF-8

- ff_CDV_Reports:
    - Name: ff_CDV_Reports
    - Type: Flat file
    - Runtime environment: cdipcapp
    - Directory: /apps/infa/shared/src
    - Date format: MM/dd/yyyy HH:mm:ss
    - Code page: UTF-8

### Step 15: Register the domain
In IDMC, register the domain using the below settings:

- Host = cdipcapp
- Port = 6005
- Domain Name = Domain_cdipc
- Security Domain = Native
- User = Administrator
- Password = infa

### Step 16: Assess the repository
In IDMC, assess the repository using the below settings:

- Security Domain = Native
- User = Administrator
- Password = infa
- Shared Directory = /tmp

### Step 17: Run the conversion
In IDMC, convert the workflows using the below settings:

- Security Domain = Native
- User = Administrator
- Password = infa
- Shared Directory = /tmp

## Configuration
- All configuration options can be adjusted in the `docker-compose.yml` file.
- Environment variables can be set in a `.env` file in the project root.
 
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

