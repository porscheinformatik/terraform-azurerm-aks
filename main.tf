data "azurerm_kubernetes_service_versions" "current" {
  location        = var.resource_group_location
  include_preview = false
}

resource "azurerm_kubernetes_cluster" "main" {
  name                              = "${var.prefix}-aks"
  location                          = var.resource_group_location
  resource_group_name               = var.resource_group_name
  dns_prefix                        = var.prefix
  node_resource_group               = "${var.prefix}-worker-rg"
  kubernetes_version                = var.kubernetes_version != null ? var.kubernetes_version : data.azurerm_kubernetes_service_versions.current.latest_version
  api_server_authorized_ip_ranges   = var.authorized_ip_ranges
  azure_policy_enabled              = true
  role_based_access_control_enabled = true

  default_node_pool {
    name                 = "default"
    node_count           = var.node_count
    vm_size              = var.vm_size
    vnet_subnet_id       = var.vnet_subnet_id
    orchestrator_version = var.kubernetes_version != null ? var.kubernetes_version : data.azurerm_kubernetes_service_versions.current.latest_version
    tags                 = var.tags
    enable_auto_scaling  = var.enable_auto_scaling
    min_count            = var.min_count
    max_count            = var.max_count
    zones                = var.availability_zones
    os_disk_type         = var.os_disk_type
    os_disk_size_gb      = var.os_disk_size_gb
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id
  }

  identity {
    type = "SystemAssigned"
  }

  azure_active_directory_role_based_access_control {
    managed                = true
    azure_rbac_enabled     = true
    admin_group_object_ids = var.admin_group_object_ids
  }

  network_profile {
    network_plugin = var.network_plugin
    network_policy = var.network_policy
    dynamic "load_balancer_profile" {
      for_each = var.outbound_ip_address_ids != null ? [1] : []
      content {
        outbound_ip_address_ids = var.outbound_ip_address_ids
      }
    }
  }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "name" {
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  for_each              = var.additional_node_pools
  name                  = each.key
  node_count            = each.value.node_count
  vm_size               = each.value.vm_size
  vnet_subnet_id        = each.value.vnet_subnet_id
  orchestrator_version  = each.value.kubernetes_version != null ? each.value.kubernetes_version : data.azurerm_kubernetes_service_versions.current.latest_version
  zones                 = each.value.availability_zones
  enable_auto_scaling   = each.value.enable_auto_scaling
  min_count             = each.value.min_count
  max_count             = each.value.max_count
  os_disk_type          = each.value.os_disk_type
  os_disk_size_gb       = each.value.os_disk_size_gb

}

resource "azurerm_log_analytics_workspace" "main" {
  name                = "${var.prefix}-law"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  sku                 = var.log_analytics_workspace_sku
  retention_in_days   = var.log_retention_in_days

  tags = var.tags
}

provider "kubernetes" {
  alias                  = "aks_k8s_provider"
  host                   = azurerm_kubernetes_cluster.main.kube_admin_config.0.host
  username               = azurerm_kubernetes_cluster.main.kube_admin_config.0.username
  password               = azurerm_kubernetes_cluster.main.kube_admin_config.0.password
  client_certificate     = base64decode(azurerm_kubernetes_cluster.main.kube_admin_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.main.kube_admin_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.main.kube_admin_config.0.cluster_ca_certificate)
}
