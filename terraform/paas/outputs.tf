output "kube_config" {
  value     = azurerm_kubernetes_cluster.sample-app-AKS.kube_config_raw
  sensitive = true
}