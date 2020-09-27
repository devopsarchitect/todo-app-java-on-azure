

# Launch the Azure Cloud Shell from the Azure portal and choose Bash.

# Deploy Kubernetes to Azure, using CLI:

# i. Get the latest available Kubernetes version in your preferred region into a bash variable. Replace <region> with the region of your choosing, for example eastus.

  version=$(az aks get-versions -l <region> --query 'orchestrators[-1].orchestratorVersion' -o tsv)
# ii. Create a Resource Group

  az group create --name akshandsonlab --location EastUS
# iii. Create AKS using the latest version available

 az aks create --resource-group akshandsonlab --name <unique-aks-cluster-name> --enable-addons monitoring --kubernetes-version $version --generate-ssh-keys --location <region>
# may take 10-15 minutes
# Deploy Azure Container Registry(ACR): Run the below command to create your own private container registry using Azure Container Registry (ACR).

 az acr create --resource-group akshandsonlab --name <unique-acr-name> --sku Standard --location <region>
#  Important: Enter a unique ACR name. ACR name may contain alpha numeric characters only and must be between 5 and 50 characters
# Grant AKS-generated Service Principal access to ACR : Authorize the AKS cluster to connect to the Azure Container Registry using the AKS generated Service Principal. Replace the variables $AKS_RESOURCE_GROUP, $AKS_CLUSTER_NAME, $ACR_RESOURCE_GROUP with appropriate values below and run the commands.

 # Get the id of the service principal configured for AKS
 CLIENT_ID=$(az aks show --resource-group $AKS_RESOURCE_GROUP --name $AKS_CLUSTER_NAME --query "servicePrincipalProfile.clientId" --output tsv)

 # Get the ACR registry resource id
 ACR_ID=$(az acr show --name $ACR_NAME --resource-group $ACR_RESOURCE_GROUP --query "id" --output tsv)

# Create role assignment
az role assignment create --assignee $CLIENT_ID --role acrpull --scope $ACR_ID
# For more information see document on how to Authenticate with Azure Container Registry from Azure Kubernetes Service


# Create Azure SQL server and Database: Create an Azure SQL server.

 az sql server create -l <region> -g akshandsonlab -n <unique-sqlserver-name> -u sqladmin -p P2ssw0rd1234
# Create a database

 az sql db create -g akshandsonlab -s <unique-sqlserver-name> -n mhcdb --service-objective S0
#  Important: Enter a unique SQL server name. Since the Azure SQL Server name does not support UPPER / Camel casing naming conventions, use lowercase for the SQL Server Name field value.
