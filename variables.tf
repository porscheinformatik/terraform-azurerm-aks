variable "resource_group_name" {
  description = "The name of the resource group to create the cluster in"
}

variable "resource_group_location" {
  description = "The resource group location"
}

variable "prefix" {
  description = "The prefix for the resources created in the specified Azure Resource Group"
}

variable "additional_node_pools" {
  type = map(object({
    node_count          = number
    vm_size             = string
    kubernetes_version  = string
    zones               = list(string)
    taints              = list(string)
    enable_auto_scaling = bool
    min_count           = number
    max_count           = number
    vnet_subnet_id      = string
  }))
  default = {}
}

variable "vm_size" {
  description = "VM size/type of the default node pool"
  default     = "Standard_B2ms"
}

variable "node_count" {
  description = "The number of nodes that should exist in the default node pool"
  default     = 2
}

variable "vnet_subnet_id" {
  type        = string
  default     = null
  description = "ID if the Subnet to deploy nodes to"
}

variable "enable_auto_scaling" {
  description = "Enable auto scaling for the default node pool"
  default     = false
}

variable "min_count" {
  description = "Min auto scaling node count for the default node pool"
  default     = null
}

variable "max_count" {
  description = "Max auto scaling node count for the default node pool"
  default     = null
}

variable "availability_zones" {
  description = "Availability zones for the default node pool"
  default     = ["1", "2", "3"]
}

variable "kubernetes_version" {
  type    = string
  default = null
}

variable "admin_group_object_ids" {
  description = "Object ID of groups with admin access."
  type        = list(string)
  default     = []
}

variable "namespaces" {
  description = "A list of namespaces to be created, owner is the username (e-mail) in AAD"
  type        = map(object({ owner = string }))
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on all created resources"
  default     = {}
}

variable "authorized_ip_ranges" {
  type        = list(string)
  description = "The IP ranges to whitelist for incoming traffic to the API Server."
  default     = []
}

variable "log_analytics_workspace_sku" {
  description = "The SKU (pricing level) of the Log Analytics workspace. For new subscriptions the SKU should be set to PerGB2018"
  type        = string
  default     = "PerGB2018"
}

variable "log_retention_in_days" {
  description = "The retention period for the logs in days"
  type        = number
  default     = 30
}

variable "outbound_ip_address_ids" {
  type = set(string)
  default = null
  description = "(Optional) The ID of the Public IP Addresses which should be used for outbound communication for the cluster load balancer."
}
