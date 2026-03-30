locals {
  environments = ["dev", "staging", "prod"]
}

resource "kubernetes_namespace" "env" {
  for_each = toset(local.environments)

  metadata {
    name = each.key
    labels = {
      environment = each.key
      managed-by  = "terraform"
    }
  }
}

resource "kubernetes_resource_quota" "env" {
  for_each = toset(local.environments)

  metadata {
    name      = "resource-quota"
    namespace = kubernetes_namespace.env[each.key].metadata[0].name
  }

  spec {
    hard = {
      "requests.cpu"    = each.key == "prod" ? "8"    : "4"
      "requests.memory" = each.key == "prod" ? "16Gi" : "8Gi"
      "limits.cpu"      = each.key == "prod" ? "16"   : "8"
      "limits.memory"   = each.key == "prod" ? "32Gi" : "16Gi"
      pods              = "50"
    }
  }
}
