output "kubeconfig" {
  value     = kind_cluster.idp.kubeconfig
  sensitive = true
}

output "cluster_name" {
  value = kind_cluster.idp.name
}
