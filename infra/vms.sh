az vm create \
  --resource-group AzureCorp-RG \
  --name AzureCorp-VM-Win \
  --image Win2019Datacenter \
  --admin-username azureuser \
  --admin-password P@ssw0rd1234! \
  --vnet-name AzureCorp-VNet \
  --subnet Web-Subnet \
  --nsg AzureCorp-NSG \
  --public-ip-address AzureCorp-VM-Win-IP \
  --size Standard_B1s

az vm run-command invoke \
  --resource-group AzureCorp-RG \
  --name AzureCorp-VM-Win \
  --command-id RunPowerShellScript \
  --scripts "Install-WindowsFeature -name Web-Server -IncludeManagementTools"

az vm create \
  --resource-group AzureCorp-RG \
  --name AzureCorp-VM-Linux \
  --image UbuntuLTS \
  --admin-username azureuser \
  --authentication-type password \
  --admin-password P@ssw0rd1234! \
  --vnet-name AzureCorp-VNet \
  --subnet Web-Subnet \
  --nsg AzureCorp-NSG \
  --public-ip-address AzureCorp-VM-Linux-IP \
  --size Standard_B1s

az vm run-command invoke \
  --resource-group AzureCorp-RG \
  --name AzureCorp-VM-Linux \
  --command-id RunShellScript \
  --scripts "sudo apt update && sudo apt install apache2 -y"
