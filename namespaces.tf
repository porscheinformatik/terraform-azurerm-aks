resource "kubernetes_namespace" "namespace" {
  provider = kubernetes.aks_k8s_provider
  for_each = var.namespaces
  metadata {
    name = each.key
  }
  depends_on = [azurerm_kubernetes_cluster.main]
}

resource "kubernetes_role_binding" "namespace_admin" {
  provider = kubernetes.aks_k8s_provider
  for_each = var.namespaces
  metadata {
    name      = "admin"
    namespace = each.key
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "admin"
  }
  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "User"
    name      = each.value.owner
  }
  depends_on = [azurerm_kubernetes_cluster.main]
}
