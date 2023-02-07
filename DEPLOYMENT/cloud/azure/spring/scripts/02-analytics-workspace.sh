#!/bin/bash

echo "############# Start creating log-analytics workspace #############"

source 01-variables


### Create analytics workspace
echo "################ Create analytics workspace:  ${analyticsWorkspaceName} ###############"
az monitor log-analytics workspace create \
--workspace-name ${analyticsWorkspaceName} \
--resource-group ${resourceGroup} \
--location ${resourceLocation} \
--query id --output tsv

echo "######################################################"

### Verify the creation or if the workspace exists

echo "############  show details from ${analyticsWorkspaceName} ##########"
az monitor log-analytics workspace show \
--resource-group ${resourceGroup} \
--workspace-name ${analyticsWorkspaceName} \
--query id --output tsv

echo "######################################################"

### Save the workspace id on a variable
export analyticsWorkspaceId=$( az monitor log-analytics workspace show \
--resource-group ${resourceGroup} \
--workspace-name ${analyticsWorkspaceName} \
--query id | jq -r)

echo "####  workspace id is ${analyticsWorkspaceId}"


### Get the id for the Spring App Service
echo "################ Show the spring app on tsv format ###############"
az spring show \
--name ${springInstance} \
--resource-group ${resourceGroup} \
--query id --output tsv

echo "######################################################"

### Save the spring service id into a variable
export springServiceId=$(az spring show \
--name ${springInstance} \
--resource-group ${resourceGroup} \
--query id | jq -r  )

echo "### spring service id is ${springServiceId}"
###

echo "###### Creating monitor  ${monitorSettingsName} ###########"
az monitor diagnostic-settings create \
--name ${monitorSettingsName} \
--resource ${springServiceId} \
--workspace ${analyticsWorkspaceId} \
--logs '[
         {
             "category": "ApplicationConsole",
             "enabled": true,
             "retentionPolicy": {
                 "enabled": false,
                 "days": 0
             }
         },
         {
             "category": "SystemLogs",
             "enabled": true,
             "retentionPolicy": {
                 "enabled": false,
                 "days": 0
             }
         }
     ]'

echo "######################################################"


### list your 
echo "################ List all monitors on service ${springServiceId} ####################"
 az monitor diagnostic-settings list --resource ${springServiceId} 

echo "#############################################################"

# Display details of your  Monitor Settings
echo "################ Display monitor details on ${monitorSettingsName} ###############"
az monitor diagnostic-settings show \
--name ${monitorSettingsName} \
--resource  ${springServiceId}
echo "######################################################"


echo "############# End of the script #############"