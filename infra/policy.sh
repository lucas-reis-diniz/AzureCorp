#!/bin/bash

RG="AzureCorp-RG"
SUBSCRIPTION_ID=$(az account show --query id -o tsv)

# Criar definição de política
az policy definition create \
  --name location-brazil-only \
  --display-name "Permitir apenas Brasil como localização" \
  --description "Bloquear criação de recursos fora de brazilsouth" \
  --rules '{
    "if": {
      "field": "location",
      "notEquals": "brazilsouth"
    },
    "then": {
      "effect": "deny"
    }
  }' \
  --mode All

# Atribuir política ao resource group
az policy assignment create \
  --name restrict-location \
  --display-name "Restringir Localização" \
  --scope /subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RG \
  --policy location-brazil-only

# Aplicar tags
az resource tag \
  --tags Projeto=AzureCorp Ambiente=Dev Dono=Lucas \
  --ids $(az resource list --resource-group $RG --query "[].id" -o tsv)

# Criar lock no RG
az lock create \
  --name LockRG \
  --lock-type CanNotDelete \
  --resource-group $RG
