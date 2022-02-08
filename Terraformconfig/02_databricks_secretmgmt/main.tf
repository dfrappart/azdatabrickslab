######################################################################
# Access to Azure
######################################################################

terraform {
  
  #backend "azurerm" {}
  required_providers {
    azurerm = {}
    databricks = {
      source = "databrickslabs/databricks"
    }

  }
}


provider "azurerm" {
  subscription_id                          = var.AzureSubscriptionID
  #client_id                                = var.AzureClientID
  #client_secret                            = var.AzureClientSecret
  #tenant_id                                = var.AzureTenantID

  features {}
  
}


provider "databricks" {
  azure_workspace_resource_id = data.azurerm_databricks_workspace.DtbsWS.id
  #azure_client_id             = var.AzureClientID
  #azure_client_secret         = var.AzureClientSecret
  #azure_tenant_id             = var.AzureTenantID

}


######################################################################
# Module call
######################################################################

module "SecretString" {
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks//002_RandomPassword/"

  #Module variable
  stringlenght                               = 16

}

######################################################################
# databricks resources



# secret management

resource "databricks_secret_scope" "kv" {
  name = "keyvault-managed"

  keyvault_metadata {
    resource_id = data.azurerm_key_vault.keyvault.id
    dns_name    = data.azurerm_key_vault.keyvault.vault_uri
  }
}

resource "databricks_secret_acl" "kv_acl" {
    principal = data.databricks_current_user.me.user_name
    permission = "MANAGE"
    scope = databricks_secret_scope.kv.name
}

/*
resource "databricks_secret" "testputsecretfromdtbs" {
    key = "testputsecretfromdtbs"
    string_value = module.SecretString.Result
    scope = databricks_secret_scope.kv.id
}
*/