cls

$AKS_RESOURCE_GROUP="k8s-tech-brief-rg"
$LOCATION="eastus2"
$AKS_NAME="ktb-aks"


az group create --location $LOCATION `
                --resource-group $AKS_RESOURCE_GROUP


az deployment group create --resource-group $AKS_RESOURCE_GROUP `
                            --template-file "aksResource.bicep" `
                            --parameters name=$AKS_NAME

az aks get-credentials --name $AKS_NAME `
                       --resource-group $AKS_RESOURCE_GROUP


helm repo add scubakiz https://scubakiz.github.io/clusterinfo/
helm repo update
helm install clusterinfo scubakiz/clusterinfo