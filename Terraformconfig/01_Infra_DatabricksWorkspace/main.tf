######################################################################
# Access to Azure
######################################################################

terraform {
  
  #backend "azurerm" {}
  required_providers {
    azurerm = {}
    ##databricks = {
    #  source = "databrickslabs/databricks"
    #}

  }
}

provider "azurerm" {
  subscription_id                          = var.AzureSubscriptionID
  client_id                                = var.AzureClientID
  client_secret                            = var.AzureClientSecret
  tenant_id                                = var.AzureTenantID

  features {}
  
}
/*
provider "databricks" {
  azure_workspace_resource_id = module.DTBWS.DTBSWFull.id
  azure_client_id             = var.AzureClientID
  azure_client_secret         = var.AzureClientSecret
  azure_tenant_id             = var.AzureTenantID

}
*/


######################################################################
# Module call
######################################################################

######################################################################
# Azure resources

# Creating the Resource Group

module "ResourceGroup" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks//003_ResourceGroup/"
  #Module variable      
  RGSuffix                                = var.ResourcesSuffix
  RGLocation                              = var.AzureRegion
  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  EnvironmentTag                          = var.Environment
  Project                                 = var.Project

}

# Creating the Databricks workspace

module "DTBWS" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Custom_Modules/PaaS_VNetIntegrateddDatabrick"
  #Module variable      
  TargetRG                                = module.ResourceGroup.RGFull.name
  AzureRegion                             = module.ResourceGroup.RGFull.location
  STALogId                                = data.azurerm_storage_account.STALog.id
  LawLogId                                = data.azurerm_log_analytics_workspace.LAWLog.id
  LawLogLocation                          = data.azurerm_log_analytics_workspace.LAWLog.location
  LawLogWorkspaceId                       = data.azurerm_log_analytics_workspace.LAWLog.workspace_id
  DTBWSSku                                = var.DTBWSSku
  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  Environment                             = var.Environment
  Project                                 = var.Project

}

/*
resource "azurerm_monitor_diagnostic_setting" "DatabricksDiag" {
  name                                  = "diag-${module.DTBWS.DTBSWFull.name}"
  target_resource_id                    = module.DTBWS.DTBSWId
  storage_account_id                    = data.azurerm_storage_account.STALog.id
  log_analytics_workspace_id            = data.azurerm_log_analytics_workspace.LAWLog.id


  dynamic "log" {
    for_each = var.logcategories
    iterator = each
    content {
      category                          = each.value.LogCatName
      enabled                           = each.value.IsLogCatEnabled
      retention_policy {
        enabled                         = each.value.IsRetentionEnabled
        days                            = each.value.RetentionDay
      }
    }
  }

}
*/
######################################################################
# databricks resources

/*




resource "databricks_user" "sheldon" {
  user_name    = "sheldon@teknews.cloud"
}

resource "databricks_user" "faye" {
  user_name    = "faye@teknews.cloud"
}

resource "databricks_group_member" "omgsheldonisadmin" {
  group_id = data.databricks_group.admins.id
  member_id = databricks_user.sheldon.id
}




/*

resource "databricks_cluster" "cluster1" {
  cluster_name = "value"
  spark_version = "value"
  driver_node_type_id = "value"
  node_type_id = "value"
  instance_pool_id = "value"
  policy_id = "value"
  autotermination_minutes = 20

  autoscale {
    min_workers = 1
    max_workers = 3
  }


}

*/