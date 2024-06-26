## This repo is built for template for deploying IaC using bicep with github actions

This template repo has a simple code sample to deploy a resource group and storage account. The folder structure is a standard way to maintain so that we put all azure resources under modules folder and call them from main.bicep. This way we can reduce the code reqrite when we need to use same code across environments. 


## Deploying from github

* Read https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-azure and 
https://docs.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-portal%2Clinux#use-the-azure-login-action-with-openid-connect

* We need a service principal that we will use to deploy resources to azure. Defaults to "Sandbox-01" which has subscription id "3079be22-73e7-41f2-a5e1-62a312d27daf". Please change it to the subscription that you need. 

    ```
    az ad sp create-for-rbac --name "bicep-iac-sp" --role contributor --scopes /subscriptions/3079be22-73e7-41f2-a5e1-62a312d27daf --sdk-auth    
    ```


* Add repository secrets with name "AZURE_CLIENT_ID" and "AZURE_TENANT_ID", "AZURE_SUBSCRIPTION_ID"

* This template repo also contains sample github actions pipelines. The pipelines are set to auto trigger, refer the pipelines for more details 

* We will use openID connect to safely deploy resources to azure using github actions which will have automatic key rotation during each workflow run


# Deploying locally (Just for testing)

You can use the below command to deploy locally.

```
az login
az account list
az account set -s "subscriptionid"
az deployment sub what-if --location westeurope --template-file test-parameters.bicep # To get the deploy plan

```
