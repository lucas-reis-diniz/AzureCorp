

RG="AzureCorp-RG"
GROUP_NAME="AzureCorp-Admins"
USER_UPN="lucas.operador@SEUDOMINIO.onmicrosoft.com"
SUBSCRIPTION_ID=$(az account show --query id -o tsv)

az ad group create --display-name $GROUP_NAME --mail-nickname azurecorpadmins

az ad user create \
  --display-name "Lucas Operador" \
  --user-principal-name $USER_UPN \
  --password P@ssword1234 \
  --force-change-password-next-login true

USER_ID=$(az ad user show --id $USER_UPN --query objectId -o tsv)
az ad group member add --group $GROUP_NAME --member-id $USER_ID

GROUP_ID=$(az ad group show --group $GROUP_NAME --query objectId -o tsv)

az role assignment create \
  --assignee-object-id $GROUP_ID \
  --role Reader \
  --scope /subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RG
