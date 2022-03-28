######################################################
# Variables
######################################################

##############################################################
#Variable declaration for provider

##############################################################
#Variable declaration for provider

variable "AzureSubscriptionID" {
  type                          = string
  description                   = "The subscription id for the authentication in the provider"
}

variable "AzureClientID" {
  type                          = string
  description                   = "The application Id, taken from Azure AD app registration"
}


variable "AzureClientSecret" {
  type                          = string
  description                   = "The Application secret"

}

variable "AzureTenantID" {
  type                          = string
  description                   = "The Azure AD tenant ID"
}

variable "AzureADClientID" {
  type                          = string
  description                   = "The application Id, taken from Azure AD app registration for Azure AD provider"
}


variable "AzureADClientSecret" {
  type                          = string
  description                   = "The Application secretfor Azure AD provider"

}


variable "IsDeploymentTypeGreenField" {
  type                        = string
  default                     = true
  description                 = "Describe the type of deployment, can be GreenField or not. If GreenField, means that the subscription setup is not applied on a newly Created subscription."


}


###################################################################
#variable declaration az log config

variable "RGLogLocation" {
  type                          = string
  description                   = "Variable defining the region for the log resources"
  default                       = "westeurope"
}

variable "SubLogSuffix" {
  type                          = string
  description                   = "Suffix to add to the resources, by default, log"
  default                       = "log"
}

###################################################################
#variable declaration kv

variable "KVSuffix" {
  type                            = string
  description                     = "The environment, dev, prod..."
  default                         = "dfr"
}

######################################################
# Databricks KV Access policy variables

variable "Secretperms_TFApp_AccessPolicy" {
  type                            = list
  description                     = "The authorization on the secret for the Access policy"
  default                         = ["Backup","Purge","Recover","Restore","Get","List","Set","Delete"]

}

variable "Certperms_TFApp_AccessPolicy" {
  type                            = list
  description                     = "The authorization on the secret for the Access policy"
  default                         = ["Backup","deleteissuers","Get","Getissuers","listissuers","managecontacts","manageissuers","Purge","Recover","Restore","Setissuers","List","Update", "Create", "Import", "Delete"]

}

variable "Secretperms_DTBSAdmins_AccessPolicy" {
  type                            = list
  description                     = "The authorization on the secret for the Access policy to grant to Databricks Admins"
  default                         = ["Backup","Purge","Recover","Restore","Get","List","Set","Delete"]

}

variable "Certperms_DTBSAdmins_AccessPolicy" {
  type                            = list
  description                     = "The authorization on the secret for the Access policy to grant to Databricks Admins"
  default                         = ["Backup","deleteissuers","Get","Getissuers","listissuers","managecontacts","manageissuers","Purge","Recover","Restore","Setissuers","List","Update", "Create", "Import", "Delete"]

}

variable "DTBSAdminsObjectId" {
  type                          = string
  description                   = "The object Id of the group which should interact with the kv in this lab"
}

######################################################
# KV variables for Cert

variable "CertName_Wildcard" {
  type                            = list
  description                     = "The certificate name as it appears in the keyvault"
  default                         = [
                                      "self-signed-dtbs-teknews-cloud",
                                      "self-signed-datalab-tek-news-cloud"
                                    ]

}

variable "CertSubject_Wildcard" {
  type                            = list
  description                     = "The certificate subject name"
  default                         = [
                                      "CN=*.dtbs.teknews.cloud",
                                      "CN=*.datalab.teknews.cloud"
                                    ]

}

variable "DNSNames_Wildcard" {
  type                            = list
  description                     = "The DNS name associated to the certificate"
  default                         = [
                                      "*.dtbs.teknews.cloud",
                                      "*.datalab.teknews.cloud"                                  
                                    ]

}

###################################################################
#common variables

variable "AzureRegion" {
  type                            = string
  description                     = "The Azure region for deployment"
  default                         = "westeurope"
}


variable "ResourceOwnerTag" {
  type                          = string
  description                   = "Tag describing the owner"
  default                       = "CloudTeam"
}

variable "CountryTag" {
  type                          = string
  description                   = "Tag describing the Country"
  default                       = "fr"
}

variable "CostCenterTag" {
  type                          = string
  description                   = "Tag describing the Cost Center"
  default                       = "subsetup"
}


variable "Company" {
  type                          = string
  description                   = "The Company owner of the resources"
  default                       = "df"
}

variable "Project" {
  type                          = string
  description                   = "The name of the project"
  default                       = "subsetup"
}

variable "Environment" {
  type                          = string
  description                   = "The environment, dev, prod..."
  default                       = "lab"
}




##############################################################
#Variable Observability basics

variable "ASCPricingTier" {
  type          = string
  description   = "The Azure Security Center Pricing Tiers, can be Free or Standard"
  default       = "Free"
}


variable "ASCContactMail" {
  type          = string
  description   = "The Azure Security Center Pricing Tiers, can be Free or Standard"

}

variable "notifySecContact" {
  type          = string
  description   = "Are the Security Contact notified by ASC ? Defualt to True"
  default       = true
}

variable "notifySubAdmins" {
  type          = string
  description   = "Are the Subscription Admins notified by ASC ? Defualt to True"
  default       = true
}

variable "SubContactList" {
  type          = string
  description   = "The contactlist email address for the alerting"


}

##############################################################
#Variable for data source

variable "DTBSAADAppreg" {
  type          = string
  description   = "The display name of an existing application registration"

}