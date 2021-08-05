#############################################################################
#This file is used to define data source refering to Azure existing resources
#############################################################################


#############################################################################
#data sources


data "azurerm_subscription" "current" {}

data "azurerm_client_config" "currentclientconfig" {}




#############################################################################
#data source for Network State



data "terraform_remote_state" "Subsetupstate" {
  backend                     = "azurerm"
  config                      = {
    storage_account_name      = var.SubsetupSTOAName
    container_name            = var.SubsetupContainerName
    key                       = var.SubsetupKey
    access_key                = var.SubsetupAccessKey
  }
}

#############################################################################
#Data source for the RG Log

data "azurerm_resource_group" "RGLog" {
  name                  = data.terraform_remote_state.Subsetupstate.outputs.RGLogName
}

#Data source for the log storage

data "azurerm_storage_account" "STALog" {
  name                  = data.terraform_remote_state.Subsetupstate.outputs.STALogName
  resource_group_name   = data.azurerm_resource_group.RGLog.name
}

#Data source for the log analytics workspace

data "azurerm_log_analytics_workspace" "LAWLog" {
  name                  = data.terraform_remote_state.Subsetupstate.outputs.SubLogAnalyticsName
  resource_group_name   = data.azurerm_resource_group.RGLog.name
}

#Data source for the ACG

data "azurerm_monitor_action_group" "SubACG" {
  name                  = data.terraform_remote_state.Subsetupstate.outputs.DefaultSubActionGroupName
  resource_group_name   = data.azurerm_resource_group.RGLog.name
}

#############################################################################
#data source for the keyvault AGW

data "azurerm_key_vault" "keyvault" {
  name                        = data.terraform_remote_state.Subsetupstate.outputs.KeyVault_Name 
  resource_group_name         = data.terraform_remote_state.Subsetupstate.outputs.KeyVault_RG
}


# data sourcing the cert

data "azurerm_key_vault_certificate" "KVCert" {
  name                        = data.terraform_remote_state.Subsetupstate.outputs.Cert1Name
  key_vault_id                = data.azurerm_key_vault.keyvault.id
}

# also data sourcing the cert as a secret to get the secret identifier

data "azurerm_key_vault_secret" "KVSecret" {
  name                        = data.terraform_remote_state.Subsetupstate.outputs.Cert1Name
  key_vault_id                = data.azurerm_key_vault.keyvault.id
}

# data source for app reg created manually at this time

data "azurerm_key_vault_secret" "KVSecretAppId" {
  name                        = data.terraform_remote_state.Subsetupstate.outputs.KVDTBSAppId
  key_vault_id                = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "KVSecretAppSecret" {
  name                        = data.terraform_remote_state.Subsetupstate.outputs.KVDTBSAppSecretName
  key_vault_id                = data.azurerm_key_vault.keyvault.id
}

data "azuread_service_principal" "databricksSP" {
  application_id              = data.azurerm_key_vault_secret.KVSecretAppId.value
}
