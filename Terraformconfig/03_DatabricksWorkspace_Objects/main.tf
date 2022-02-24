######################################################################
# Access to Azure
######################################################################

terraform {
  
  backend "azurerm" {}
  required_providers {
    azurerm = {}
    azuread = {}
    databricks = {
      source = "databrickslabs/databricks"
      #configuration_aliases = [databricks.testformodule]
    }

  }
}


provider "azurerm" {
  subscription_id                          = var.AzureSubscriptionID
  client_id                                = var.AzureClientID
  client_secret                            = var.AzureClientSecret
  tenant_id                                = var.AzureTenantID

  features {}
  
}

provider "azuread" {
  
  client_id                                = var.AzureADClientID
  client_secret                            = var.AzureADClientSecret
  tenant_id                                = var.AzureTenantID

  #features {}
  
}

provider "databricks" {
  azure_workspace_resource_id             = data.azurerm_databricks_workspace.DtbsWS.id
  azure_client_id                         = var.AzureClientID
  azure_client_secret                     = var.AzureClientSecret
  azure_tenant_id                         = var.AzureTenantID
  #alias                                   = "testformodule"

}


######################################################################
# Module call
######################################################################


######################################################################
# databricks resources

# Users management

resource "databricks_user" "sheldon" {
  user_name                   = "sheldon@teknews.cloud"
}

resource "databricks_user" "faye" {
  user_name                   = "faye@teknews.cloud"
}

resource "databricks_group_member" "omgsheldonisadmin" {
  group_id                    = data.databricks_group.admins.id
  member_id                   = databricks_user.sheldon.id
}

# Compute

data "databricks_node_type" "smallest" {
  local_disk                  = true
    }

data "databricks_spark_version" "latest_lts" {
  long_term_support           = true
    }

resource "databricks_instance_pool" "dbxpool" {
  instance_pool_name          = "poolcluster"
  min_idle_instances          = 0
  max_capacity                = 3
  node_type_id                = data.databricks_node_type.smallest.id
  azure_attributes {
  }
  idle_instance_autotermination_minutes = 30
  disk_spec {
    disk_type {
      azure_disk_volume_type  = "STANDARD_LRS"
    }
    disk_size = 40
    disk_count = 1
  }
}

resource "databricks_cluster" "dbxcluster" {
    cluster_name            = "my-interactive-cluster"
    spark_version           = data.databricks_spark_version.latest_lts.id
    instance_pool_id        = databricks_instance_pool.dbxpool.id
    #node_type_id            = data.databricks_node_type.smallest.id #optional if instance_pool_id
    autoscale {
            min_workers = 1
            max_workers = 3
                }
    autotermination_minutes = 60
    library {
      pypi {
        package = "mlflow"
      }
    }
}


# Module databricks

module "databrickscluster" {
#providers = {
#  databricks.insidemodule = databricks.testformodule
#}

  #Module Location
  source                                  = "../../Modules/DTBSCluster"
  #Module variable      

}

