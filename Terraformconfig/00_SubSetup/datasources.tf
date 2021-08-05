



data "azurerm_subscription" "current" {}

data "azurerm_client_config" "currentclientconfig" {}

# Referencing existing azure ad application registration

data "azuread_application" "DTBSAADAppreg" {
  display_name = var.DTBSAADAppreg
}