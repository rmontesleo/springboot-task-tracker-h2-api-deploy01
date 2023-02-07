#!/bin/bash

source 01-variables

echo "Hello ${demo}"
echo "##### Starting the Basic deployment on Spring Service"

# TODO: Validate you can login to the azure account
# TODO: Validate the jar is created
# TODO: Send output messages to describe what is happening


### Show account details
az account show --output table


### List  your accounts
az account list --output table

### Create the resource group
echo "################ Create Resource Group ###############"
az group create --location eastus --name ${resourceGroup}

echo "######################################################"

# this command returns a json array
az group list

# this show in a tabular form
az group list --output table


### Create the Azure Spring cloud Instance Service
# This commands create a service to handle one or more apps in azure
# this take some minutes to be created.
# sku  Basic, Standard, Enterprise
echo "################ Create Spring Service ###############"
az spring create --resource-group ${resourceGroup} \
--name ${springInstance} \
--sku Basic
echo "######################################################"


### create the Spring App

# select the required java version, default is java 8
echo "################ Create Spring App ####################"
az spring app create --name ${springApp} \
--resource-group ${resourceGroup} \
--service ${springInstance} \
--runtime-version ${runtimeVersion} \
--memory ${applicationMemory} \
--assign-endpoint ${assignEndpoint} \
--verbose
echo "######################################################"

### Show details of thw spring app
echo "################ Show Spring App Details ###############"
az spring app show --name ${springApp} \
--resource-group ${resourceGroup} \
--service ${springInstance}
echo "######################################################"


### deploy the jar 
# This task takes some time to be completed
echo "################ Deploy the JAR ###############"
az spring app deploy --name ${springApp} \
--artifact-path ${FULL_PATH}/${JAR_NAME}  \
--resource-group ${resourceGroup} \
--service ${springInstance} \
--verbose
echo "######################################################"

### Get again details of the spring app with the deployed jar
echo "################ Show Spring App details ###############"
az spring app show --name ${springApp} \
--resource-group ${resourceGroup} \
--service ${springInstance} 

echo "######################################################"




echo "################ End of the test ################"