######################################################################
# Access to Azure
######################################################################

terraform {
  
  backend "azurerm" {}
  required_providers {
    azurerm = {}
    azuread = {}


  }
}

provider "azuread" {
  
  client_id                                = var.AzureADClientID
  client_secret                            = var.AzureADClientSecret
  tenant_id                                = var.AzureTenantID

  #features {}
  
}

provider "azurerm" {
  subscription_id                          = var.AzureSubscriptionID
  client_id                                = var.AzureClientID
  client_secret                            = var.AzureClientSecret
  tenant_id                                = var.AzureTenantID

  features {}
  
}




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

# Creating some storage

module "STAdatalake" {
  
  count                                 = var.STACount
  #Module Location
  source                                = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks//101_StorageAccountGP"
  #Module variable    
  STASuffix                             = "dtbslab${count.index+1}"
  RGName                                = module.ResourceGroup.RGFull.name
  StorageAccountLocation                = module.ResourceGroup.RGFull.location
  IsHNSEnabled                          = true



}


module "datalakefilesystem" {
  
  count                                 = var.STACount
  #Module Location
  source                                = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks///104_Datalakev2FS"
  #Module variable    
  DatalakeFSName                        = "dtbslab${count.index+1}"
  STAId                                 = module.STAdatalake[count.index].STAFull.id

}




# Assigning the app registration used by databricks to storage



module "AssignDTBS_STADataContrib" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks//401_RBACAssignment_BuiltinRole/"

  #Module variable
  RBACScope                               = module.ResourceGroup.RGFull.id
  BuiltinRoleName                         = "Storage Blob Data Contributor"
  ObjectId                                = data.azuread_service_principal.databricksSP.object_id


}