resource "kubernetes_network_policy" "deny_all" {
  for_each = toset(local.environments)

  metadata {
    name      = "deny-all-ingress"
    namespace = kubernetes_namespace.env[each.key].metadata[0].name
  }

  spec {
    pod_selector {}
    policy_types = ["Ingress"]
  }
}

resource "kubernetes_network_policy" "allow_same_ns" {
  for_each = toset(local.environments)

  metadata {
    name      = "allow-same-namespace"
    namespace = kubernetes_namespace.env[each.key].metadata[0].name
  }

  spec {
    pod_selector {}
    ingress {
      from {
        pod_selector {}
      }
    }
    policy_types = ["Ingress"]
  }
}
