######################################################
#VNet ouputs

output "VNetName" {
  value                 = module.DTBWS.VNetName
}

output "VNetId" {
  value                 = module.DTBWS.VNetId
  sensitive             = true
}

output "VNetAddressSpace" {
  value                 = module.DTBWS.VNetAddressSpace
}

output "VNetRGName" {
  value                 = module.DTBWS.VNetRGName
}

output "VNetLocation" {
  value                 = module.DTBWS.VNetLocation
}

output "VNetFull" {
  value                 = module.DTBWS.VNetFull
  sensitive             = true
}

######################################################
#Subnet ouputs

output "SubnetNames" {
  value                 = module.DTBWS.SubnetNames
}

output "SubnetIds" {
  value                 = module.DTBWS.SubnetIds
  sensitive             = true
}

output "SubnetAddressPrefixes" {
  value                 = module.DTBWS.SubnetAddressPrefixes
}

output "SubnetFull" {
  value                 = module.DTBWS.SubnetFull
  sensitive             = true
}

######################################################
#NSG ouputs

output "NSGNames" {
  value                 = module.DTBWS.NSGNames
}

output "NSGIds" {
  value                 = module.DTBWS.NSGIds
}

output "NSGFull" {
  value                 = module.DTBWS.NSGFull
  sensitive             = true
}

######################################################
#Databricks workspace ouputs

output "DTBSWFull" {
  value                 = module.DTBWS.DTBSWFull
  sensitive             = true

}

output "DTBSWId" {
  value                 = module.DTBWS.DTBSWId
  sensitive             = true
}

output "DTBSWManagedRGId" {
  value                 = module.DTBWS.DTBSWManagedRGId
}

output "DTBSWName" {
  value                 = module.DTBWS.DTBSWName
}

/*
######################################################
#Databricks ouputs

output "databricksAdminGroup" {
  value                 = data.databricks_group.admins
  sensitive = true
}

output "databricksUser" {
  value                 = databricks_user.sheldon
  sensitive = true
}
*/