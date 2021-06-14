######################################################
# Module DTBS Outputs
######################################################

######################################################
# Node Type Data ouputs

output "NodeTypeData" {
  value                 = data.databricks_node_type.NodeTypeData
  sensitive             = true
}

output "SparkData" {
  value                 = data.databricks_spark_version.SparkData
  sensitive             = true
}

output "ClusterData" {
  value                 = databricks_cluster.dtbscluster
  sensitive             = true
}

