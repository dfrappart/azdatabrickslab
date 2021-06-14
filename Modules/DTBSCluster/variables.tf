######################################################
# Module dtbs Variables
######################################################

######################################################
# Node Type Data

variable "IsLocalDiskEnabled" {
  type                = string
  description         = "Pick only nodes with local storage."
  default             = true
  
}

variable "NodeMinMemory" {
  type                = string
  description         = "Minimum amount of memory per node in gigabytes. Defaults to 0."
  default             = null

}

variable "NodeGbPerCore" {
  type                = string
  description         = "Number of gigabytes per core available on instance. Conflicts with min_memory_gb. Defaults to 0."
  default             = null

}

variable "NodeMinCore" {
  type                = string
  description         = "Minimum number of CPU cores available on instance. Defaults to 0."
  default             = null

}

variable "NodeMinGPU" {
  type                = string
  description         = "Minimum number of GPU's attached to instance. Defaults to 0."
  default             = null

}

variable "NodeCategory" {
  type                = string
  description         = "Node category, which can be one of General purpose, memory optimize, Storage Optimized, Compute Optimize, GPU"
  default             = null
}

######################################################
# Spark Data

variable "IsLTSVersion" {
  type          = string
  default       = null
  description   = " if we should limit the search only to LTS (long term support) versions. Default to false"
}

variable "IsLatestVersion" {
  type          = string
  default       = null
  description   = "if we should return only the latest version if there is more than one result. Default to true. If set to false and multiple versions are matching, throws an error"
}

variable "IsMLRuntimeOnly" {
  type          = string
  default       = null
  description   = "if we should limit the search only to ML runtimes. Default to false"
}

variable "IsHLSRuntimeOnly" {
  type          = string
  default       = null
  description   = " if we should limit the search only to Genomics (HLS) runtimes. Default to false"
}

variable "IsGPURuntimeOnly" {
  type          = string
  default       = null
  description   = " if we should limit the search only to runtimes that support GPUs. Default to false"
}

variable "IsBetaStageRuntimeOnly" {
  type          = string
  default       = null
  description   = "if we should limit the search only to runtimes that are in Beta stage. Default to false"
}

variable "ScalaVer" {
  type          = string
  default       = null
  description   = "if we should limit the search only to runtimes that are based on specific Scala version. Default to 2.12"
}

variable "SparkVer" {
  type          = string
  default       = null
  description   = "f we should limit the search only to runtimes that are based on specific Spark version. Default to empty string. It could be specified as 3, or 3.0, or full version, like, 3.0.1"
}

######################################################
# Tags

variable "ResourceOwnerTag" {
  type                = string
  description         = "Tag describing the owner"
  default             = "That would be me"
}

variable "CountryTag" {
  type                = string
  description         = "Tag describing the Country"
  default             = "fr"
}

variable "CostCenterTag" {
  type                = string
  description         = "Tag describing the Cost Center"
  default             = "lab"
}

variable "Project" {
  type                = string
  description         = "The name of the project"
  default             = "tfmodule"
}

variable "Environment" {
  type                = string
  description         = "The environment, dev, prod..."
  default             = "lab"
}


variable "extra_tags" {
  type        = map
  description = "Additional optional tags."
  default     = {}
}

######################################################
# Cluster variables

variable "ClusterSuffix" {
  type                = string
  description         = "A suffix for the Cluster name, which doesn’t have to be unique. If not specified at creation, the cluster name will be an empty string."
  default             = ""
}

variable "ClusterDriverId" {
  type                = string
  description         = "The node type of the Spark driver. This field is optional; if unset, API will set the driver node type to the same value as node_type_id defined above."
  default             = null
  
}

variable "InstancePoolId" {
  type                = string
  description         = "(Optional - required if node_type_id is not given) - To reduce cluster start time, you can attach a cluster to a predefined pool of idle instances. When attached to a pool, a cluster allocates its driver and worker nodes from the pool. If the pool does not have sufficient idle resources to accommodate the cluster’s request, it expands by allocating new instances from the instance provider. When an attached cluster changes its state to TERMINATED, the instances it used are returned to the pool and reused by a different cluster."
  default             = "empty"
  
}

variable "ClusPolicyId" {
  type                = string
  description         = "Identifier of Cluster Policy to validate cluster and preset certain defaults. The primary use for cluster policies is to allow users to create policy-scoped clusters via UI rather than sharing configuration for API-created clusters. For example, when you specify policy_id of external metastore policy, you still have to fill in relevant keys for spark_conf."
  default             = null
  
}

variable "ClusAutoTerminationTime" {
  type                = string
  description         = "Automatically terminate the cluster after being inactive for this time in minutes. If not set, Databricks won't automatically terminate an inactive cluster. If specified, the threshold must be between 10 and 10000 minutes. You can also set this value to 0 to explicitly disable automatic termination. We highly recommend having this setting present for Interactive/BI clusters."
  default             = 15
  
}

variable "IsElasticDiskEnabled" {
  type                = string
  description         = "If you don’t want to allocate a fixed number of EBS volumes at cluster creation time, use autoscaling local storage. With autoscaling local storage, Databricks monitors the amount of free disk space available on your cluster’s Spark workers. If a worker begins to run too low on disk, Databricks automatically attaches a new EBS volume to the worker before it runs out of disk space. EBS volumes are attached up to a limit of 5 TB of total disk space per instance (including the instance’s local storage). To scale down EBS usage, make sure you have autotermination_minutes and autoscale attributes set. More documentation available at cluster configuration page."
  default             = null
  
}

variable "IsLocalDiskEncrypted" {
  type                = string
  description         = "Some instance types you use to run clusters may have locally attached disks. Databricks may store shuffle data or temporary data on these locally attached disks. To ensure that all data at rest is encrypted for all storage types, including shuffle data stored temporarily on your cluster’s local disks, you can enable local disk encryption. When local disk encryption is enabled, Databricks generates an encryption key locally unique to each cluster node and encrypting all data stored on local disks. The scope of the key is local to each cluster node and is destroyed along with the cluster node itself. During its lifetime, the key resides in memory for encryption and decryption and is stored encrypted on the disk. Your workloads may run more slowly because of the performance impact of reading and writing encrypted data to and from local volumes. This feature is not available for all Azure Databricks subscriptions. Contact your Microsoft or Databricks account representative to request access."
  default             = null
  
}

variable "ClusSingleUser" {
  type                = string
  description         = "The optional user name of the user to assign to an interactive cluster. This field is required when using standard AAD Passthrough for Azure Data Lake Storage (ADLS) with a single-user cluster (i.e., not high-concurrency clusters)."
  default             = null

}

variable "ClusIdempotencyToken" {
  type                = string
  description         = "An optional token to guarantee the idempotency of cluster creation requests. If an active cluster with the provided token already exists, the request will not create a new cluster, but it will return the existing running cluster's ID instead. If you specify the idempotency token, upon failure, you can retry until the request succeeds. Databricks platform guarantees to launch exactly one cluster with that idempotency token. This token should have at most 64 characters."
  default             = null

}

variable "ClusSSHKey" {
  type                = list(string)
  description         = "SSH public key contents that will be added to each Spark node in this cluster. The corresponding private keys can be used to login with the user name ubuntu on port 2200. You can specify up to 10 keys."
  default             = null

}

variable "ClusNodeMin" {
  type                = string
  description         = "The minimum number of workers to which the cluster can scale down when underutilized. It is also the initial number of workers the cluster will have after creation."
  default             = 0

}

variable "ClusNodeMax" {
  type                = string
  description         = "The maximum number of workers to which the cluster can scale up when overloaded. max_workers must be strictly greater than min_workers."
  default             = 10

}

######################################################
# Azure Databricks specifics

variable "ClusterAvailability" {
  type                = string
  description         = "Availability type used for all subsequent nodes past the first_on_demand ones. Valid values are SPOT_AZURE, SPOT_WITH_FALLBACK_AZURE, and ON_DEMAND_AZURE. Note: If first_on_demand is zero, this availability type will be used for the entire cluster."
  default             = "SPOT_WITH_FALLBACK_AZURE"

}

variable "ClusterFirstOndemandNumber" {
  type                = string
  description         = "The first first_on_demand nodes of the cluster will be placed on on-demand instances. If this value is greater than 0, the cluster driver node will be placed on an on-demand instance. If this value is greater than or equal to the current cluster size, all nodes will be placed on on-demand instances. If this value is less than the current cluster size, first_on_demand nodes will be placed on on-demand instances, and the remainder will be placed on availability instances. This value does not affect cluster size and cannot be mutated over the lifetime of a cluster."
  default             = 1

}

variable "SpotMaxBid" {
  type                = string
  description         = "The max price for Azure spot instances. Use -1 to specify lowest price."
  default             = -1

}

