######################################################
# Module Databricks cluster + pool
######################################################

terraform {
  
  #backend "azurerm" {}
  required_providers {

    databricks = {
      source = "databrickslabs/databricks"
      #configuration_aliases = [databricks.insidemodule]
    }

  }
}


data "databricks_node_type" "NodeTypeData" {
  
  local_disk                                = var.IsLocalDiskEnabled
  min_memory_gb                             = var.NodeMinMemory
  gb_per_core                               = var.NodeGbPerCore
  min_cores                                 = var.NodeMinCore
  min_gpus                                  = var.NodeMinGPU
  category                                  = var.NodeCategory

}

data "databricks_spark_version" "SparkData" {

  long_term_support                         = var.IsLTSVersion
  latest                                    = var.IsLatestVersion
  ml                                        = var.IsMLRuntimeOnly
  genomics                                  = var.IsHLSRuntimeOnly
  gpu                                       = var.IsGPURuntimeOnly
  beta                                      = var.IsBetaStageRuntimeOnly
  scala                                     = var.ScalaVer
  spark_version                             = var.SparkVer


}


resource "databricks_cluster" "dtbscluster" {
  cluster_name                              = "dtbs-clus${var.ClusterSuffix}"
  spark_version                             = data.databricks_spark_version.SparkData.id
  driver_node_type_id                       = var.ClusterDriverId
  node_type_id                              = var.InstancePoolId == "empty" ? data.databricks_node_type.NodeTypeData.id : null
  instance_pool_id                          = var.InstancePoolId == "empty" ? null : var.InstancePoolId
  policy_id                                 = var.ClusPolicyId
  autotermination_minutes                   = var.ClusAutoTerminationTime
  enable_elastic_disk                       = var.IsElasticDiskEnabled
  enable_local_disk_encryption              = var.IsLocalDiskEncrypted
  single_user_name                          = var.ClusSingleUser
  idempotency_token                         = var.ClusIdempotencyToken
  ssh_public_keys                           = var.ClusSSHKey

  custom_tags                                = merge(local.DefaultTags, var.extra_tags)

  autoscale {
    
      min_workers                           = var.ClusNodeMin
      max_workers                           = var.ClusNodeMax
    }


# To do : try to define a way with dynamic block for library
  library {

    pypi {
    
      package = "mlflow"
    
    }
  }

  azure_attributes {
    availability                           = var.ClusterAvailability
    first_on_demand                        = var.ClusterFirstOndemandNumber
    spot_bid_max_price                     = var.SpotMaxBid

  }

}

