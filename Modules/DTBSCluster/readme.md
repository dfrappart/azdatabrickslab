# Azure Databricks workspace module

## Module description

This module allows the deployment of an Databricks Cluster.


### Module inputs

| Variable name | Variable type | Default value | Description |
|:--------------|:--------------|:--------------|:------------|
| IsLocalDiskEnabled | string | true | Pick only nodes with local storage. |
| NodeMinMemory | string | N/A | Id of the log analytic workspace containing the logs |
| NodeGbPerCore | string | westeurope | The log analytic workspace guid |
| NodeMinCore | string | westeurope | The log analytic workspace location |
| NodeMinGPU | string | "NetworkWatcher_westeurope" | The name of the network watcher instance |
| NodeCategory | string | "NetworkWatcherRG" | The name of the network watcher resource group |
| IsLTSVersion | string | N/A | The Resource Group containing all the resources for this module |
| IsLatestVersion | string | "westeurope" | The Azure location |
| IsMLRuntimeOnly | string | "dtbws" | A suffix for the Vnet name |
| IsHLSRuntimeOnly | list | ["192.168.102.0/24"] | The VNet IP Range |
| IsGPURuntimeOnly | list | ["pub-dtbs","priv-dtbs"] |A list of subnet names |
| IsBetaStageRuntimeOnly | list | ["default"] | A list for the subnet address prefixes |
| ScalaVer | list | null | The list of service endpoint for the subnets |
| SparkVer | string | "1" | A suffix for the Databricks workspace |
| ResourceOwnerTag | string | "That would be me" | Tag describing the owner |
| CountryTag | string | "fr" |Tag describing the Country |
| CostCenterTag | string | "lab" | Tag describing the Cost Center |
| Project | string | "tfmodule" | The name of the project |
| Environment | string | "lab" | The environment, dev, prod... |
| extra_tags | string | {} | Additional optional tags. |
| ClusterSuffix | string | "" | A suffix for the Cluster name, which doesn’t have to be unique. If not specified at creation, the cluster name will be an empty string. |
| ClusterDriverId | string | null | The node type of the Spark driver. This field is optional; if unset, API will set the driver node type to the same value as node_type_id defined above. |
| InstancePoolId | string | "empty" | Identifier of Cluster Policy to validate cluster and preset certain defaults. The primary use for cluster policies is to allow users to create policy-scoped clusters via UI rather than sharing configuration for API-created clusters. For example, when you specify policy_id of external metastore policy, you still have to fill in relevant keys for spark_conf. |
| ClusPolicyId | string | null | Identifier of Cluster Policy to validate cluster and preset certain defaults. The primary use for cluster policies is to allow users to create policy-scoped clusters via UI rather than sharing configuration for API-created clusters. For example, when you specify policy_id of external metastore policy, you still have to fill in relevant keys for spark_conf. |
| ClusAutoTerminationTime | string | 15 | Automatically terminate the cluster after being inactive for this time in minutes. If not set, Databricks won't automatically terminate an inactive cluster. If specified, the threshold must be between 10 and 10000 minutes. You can also set this value to 0 to explicitly disable automatic termination. We highly recommend having this setting present for Interactive/BI clusters. |
| IsElasticDiskEnabled | string | null | If you don’t want to allocate a fixed number of EBS volumes at cluster creation time, use autoscaling local storage. With autoscaling local storage, Databricks monitors the amount of free disk space available on your cluster’s Spark workers. If a worker begins to run too low on disk, Databricks automatically attaches a new EBS volume to the worker before it runs out of disk space. EBS volumes are attached up to a limit of 5 TB of total disk space per instance (including the instance’s local storage). To scale down EBS usage, make sure you have autotermination_minutes and autoscale attributes set. More documentation available at cluster configuration page. |
| IsLocalDiskEncrypted | string | null | Some instance types you use to run clusters may have locally attached disks. Databricks may store shuffle data or temporary data on these locally attached disks. To ensure that all data at rest is encrypted for all storage types, including shuffle data stored temporarily on your cluster’s local disks, you can enable local disk encryption. When local disk encryption is enabled, Databricks generates an encryption key locally unique to each cluster node and encrypting all data stored on local disks. The scope of the key is local to each cluster node and is destroyed along with the cluster node itself. During its lifetime, the key resides in memory for encryption and decryption and is stored encrypted on the disk. Your workloads may run more slowly because of the performance impact of reading and writing encrypted data to and from local volumes. This feature is not available for all Azure Databricks subscriptions. Contact your Microsoft or Databricks account representative to request access. |
| ClusSingleUser | string | null | The optional user name of the user to assign to an interactive cluster. This field is required when using standard AAD Passthrough for Azure Data Lake Storage (ADLS) with a single-user cluster (i.e., not high-concurrency clusters). |
| ClusIdempotencyToken | string | null |An optional token to guarantee the idempotency of cluster creation requests. If an active cluster with the provided token already exists, the request will not create a new cluster, but it will return the existing running cluster's ID instead. If you specify the idempotency token, upon failure, you can retry until the request succeeds. Databricks platform guarantees to launch exactly one cluster with that idempotency token. This token should have at most 64 characters. |
| ClusSSHKey | string | null | SSH public key contents that will be added to each Spark node in this cluster. The corresponding private keys can be used to login with the user name ubuntu on port 2200. You can specify up to 10 keys. |
| ClusNodeMin | string | 0 | The minimum number of workers to which the cluster can scale down when underutilized. It is also the initial number of workers the cluster will have after creation. |
| ClusNodeMax | string | 10 | The maximum number of workers to which the cluster can scale up when overloaded. max_workers must be strictly greater than min_workers. |
| ClusterAvailability | string | SPOT_WITH_FALLBACK_AZURE | Availability type used for all subsequent nodes past the first_on_demand ones. Valid values are SPOT_AZURE, SPOT_WITH_FALLBACK_AZURE, and ON_DEMAND_AZURE. Note: If first_on_demand is zero, this availability type will be used for the entire cluster. |
| ClusterFirstOndemandNumber | string | 1 | The first first_on_demand nodes of the cluster will be placed on on-demand instances. If this value is greater than 0, the cluster driver node will be placed on an on-demand instance. If this value is greater than or equal to the current cluster size, all nodes will be placed on on-demand instances. If this value is less than the current cluster size, first_on_demand nodes will be placed on on-demand instances, and the remainder will be placed on availability instances. This value does not affect cluster size and cannot be mutated over the lifetime of a cluster. |
| SpotMaxBid | string | -1 | The max price for Azure spot instances. Use -1 to specify lowest price. |

### Module outputs

| Output name | Value | Description | Sensitive |
|-|-|-|-|
| NodeTypeData | `data.databricks_node_type.NodeTypeData` | The name of the vnet | false |
| SparkData | `data.databricks_spark_version.SparkData` | The id of the vnet | true |
| ClusterData | `databricks_cluster.dtbscluster` | The address space of the vnet | false |


## Exemple configuration  



Deploy the following to have a working databricks workspace:

```bash




```

## Sample display

terraform plan should gives the following output:

```powershell



```

Output should be simmilar to this:

```bash

Outputs:



```

## Sample deployment

After deployment, something simlilar is visible in the portal:

![Illustration 1](./Img/databrickscluster001.png)

![Illustration 2](./Img/databrickscluster002.png)

![Illustration 3](./Img/databrickscluster003.png)

![Illustration 4](./Img/databrickscluster004.png)



