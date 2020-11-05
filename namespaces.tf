resource "kubernetes_namespace" "namespace" {
  for_each = var.namespaces
  metadata {
    name = each.key
  }
}

resource "kubernetes_role_binding" "namespace_admin" {
  for_each = var.namespaces
  metadata {
    name = "admin"
    namespace = each.key
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "admin"
  }
  subject {
    api_group = "rbac.authorization.k8s.io"
    kind = "User"
    name = each.value.owner
  }
}
