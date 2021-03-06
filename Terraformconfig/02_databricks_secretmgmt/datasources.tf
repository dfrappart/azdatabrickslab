#############################################################################
#This file is used to define data source refering to Azure existing resources
#############################################################################


#############################################################################
#data sources


data "azurerm_subscription" "current" {}

data "azurerm_client_config" "currentclientconfig" {}

data "databricks_current_user" "me" {
  #user_name = var.DatabricksUser
}


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

data "terraform_remote_state" "DatabricksInfra" {
  backend                     = "azurerm"
  config                      = {
    storage_account_name      = var.DatabricksInfraSTOAName
    container_name            = var.DatabricksInfraContainerName
    key                       = var.DatabricksInfraKey
    access_key                = var.DatabricksInfraAccessKey
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
#data source for the keyvault 

data "azurerm_key_vault" "keyvault" {
  name                        = data.terraform_remote_state.Subsetupstate.outputs.KeyVault_Name 
  resource_group_name         = data.terraform_remote_state.Subsetupstate.outputs.KeyVault_RG

}


# data sourcing the cert

data "azurerm_key_vault_certificate" "Cert" {
  name                        = data.terraform_remote_state.Subsetupstate.outputs.Cert1Name
  key_vault_id                = data.terraform_remote_state.Subsetupstate.outputs.KeyVault_Id

}

# also data sourcing the cert as a secret to get the secret identifier

data "azurerm_key_vault_secret" "CertSecretString" {
  name                        = data.terraform_remote_state.Subsetupstate.outputs.Cert1Name
  key_vault_id                = data.terraform_remote_state.Subsetupstate.outputs.KeyVault_Id

}

data "azurerm_databricks_workspace" "DtbsWS" {
  name                        = data.terraform_remote_state.DatabricksInfra.outputs.DTBSWName
  resource_group_name         = data.terraform_remote_state.DatabricksInfra.outputs.VNetRGName

}


#############################################################################
#data source for databricks workspace

data "databricks_group" "admins" {
    display_name = "admins"
}
