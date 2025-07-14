# AzureCorp - Projeto de Alta Disponibilidade com Load Balancer (AZ-104)

Este repositório contém os scripts e documentação de um ambiente simulado no Microsoft Azure, seguindo práticas cobradas na certificação **AZ-104: Azure Administrator**.

## 📘 Objetivo

Criar um ambiente corporativo de alta disponibilidade com:

* Duas VMs Windows Server com IIS
* Availability Set para tolerância a falhas
* Load Balancer Público com health probe
* Regras de balanceamento HTTP na porta 80

---

## ☁️ Arquitetura

```
[Usuário]
   ↓
[Azure Load Balancer - IP Público]
   ↓
 ┌────────────┬─────────────┐
 │ VMWin (IIS)│ VMWin2 (IIS)│
 └────────────┴─────────────┘
      (Availability Set)
```

---

## 📂 Estrutura do Projeto

```bash
.
├── 01_availability_set.sh        # Criação do AVSet, NSG e VMWin2
├── Alta Disponibilidade Lb.sh    # IP, Load Balancer, Backend Pool, Probe e Regras
├── README.md                     # Documentação do projeto
```

---

## 🚀 Como Executar

### 1. Execute os scripts:

```bash
bash 01_availability_set.sh
bash Alta\ Disponibilidade\ Lb.sh
```

### 2. Inicie as VMs:

```bash
az vm start --resource-group AzureCorp --name AzureCorp-VMWin
az vm start --resource-group AzureCorp --name AzureCorp-VMWin2
```

### 3. Instale o IIS e personalize as páginas:

#### Para AzureCorp-VMWin

```bash
az vm run-command invoke \
  --resource-group AzureCorp \
  --name AzureCorp-VMWin \
  --command-id RunPowerShellScript \
  --scripts "Install-WindowsFeature -name Web-Server -IncludeManagementTools"

az vm run-command invoke \
  --resource-group AzureCorp \
  --name AzureCorp-VMWin \
  --command-id RunPowerShellScript \
  --scripts "Set-Content -Path 'C:\\inetpub\\wwwroot\\index.html' -Value '<h1>Servido por: AzureCorp-VMWin</h1>'"
```

#### Para AzureCorp-VMWin2

```bash
az vm run-command invoke \
  --resource-group AzureCorp \
  --name AzureCorp-VMWin2 \
  --command-id RunPowerShellScript \
  --scripts "Install-WindowsFeature -name Web-Server -IncludeManagementTools"

az vm run-command invoke \
  --resource-group AzureCorp \
  --name AzureCorp-VMWin2 \
  --command-id RunPowerShellScript \
  --scripts "Set-Content -Path 'C:\\inetpub\\wwwroot\\index.html' -Value '<h1>Servido por: AzureCorp-VMWin2</h1>'"
```

### 4. Obtenha o IP do Load Balancer

```bash
az network public-ip show \
  --resource-group AzureCorp \
  --name AzureCorp-LB-IP \
  --query ipAddress -o tsv
```

### 5. Teste no navegador

Acesse: `http://<IP-do-LB>` e veja a resposta alternar entre as duas VMs ✅

---

## 📌 Recursos Utilizados

* Azure VMs (Windows Server 2019)
* Availability Set
* Azure Load Balancer (SKU Standard)
* Network Security Group
* Azure CLI (bash)

---

## 🧠 Aprendizados

Este projeto cobre as seguintes competências da AZ-104:

* Gerenciamento de VMs
* Configuração de alta disponibilidade
* Regras de NSG e balanceamento
* Diagnóstico com scripts remotos via CLI

---

Feito com 💙 para praticar a certificação **AZ-104** e demonstrar experiência real com **ambientes de produção simulados**.

---

📫 Conecte-se comigo no [LinkedIn](https://www.linkedin.com/in/lucas-reis-diniz/) para trocar ideias sobre nuvem, certificações e projetos!
