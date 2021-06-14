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

output "MyAccesstoDatabricks" {
    value = data.databricks_current_user.me
    sensitive = true
}