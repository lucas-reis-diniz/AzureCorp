az network vnet create \
  --name AzureCorp-VNet \
  --resource-group AzureCorp-RG \
  --address-prefix 10.0.0.0/16 \
  --subnet-name Web-Subnet \
  --subnet-prefix 10.0.1.0/24

az network vnet subnet create \
  --name Data-Subnet \
  --resource-group AzureCorp-RG \
  --vnet-name AzureCorp-VNet \
  --address-prefix 10.0.2.0/24

az network nsg create \
  --resource-group AzureCorp-RG \
  --name AzureCorp-NSG

az network nsg rule create \
  --resource-group AzureCorp-RG \
  --nsg-name AzureCorp-NSG \
  --name Allow-RDP \
  --priority 1000 \
  --direction Inbound \
  --access Allow \
  --protocol Tcp \
  --destination-port-range 3389 \
  --source-address-prefixes <SEU_IP>/32 \
  --destination-address-prefixes '*' \
  --description "Permitir RDP apenas do IP da casa"
