######################################################
#

output "DatabricksWorkspaceFull" {

    value = data.azurerm_databricks_workspace.DtbsWS
    sensitive = true
}

output "DatabricksSecretScope" {

    value = databricks_secret_scope.kv
    sensitive = true
}