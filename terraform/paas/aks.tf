resource "azurerm_user_assigned_identity" "AKS_managed_identity" {
    name                = "AKS-managed-identity"
    location            = azurerm_resource_group.paas_resource_group.location
    resource_group_name = azurerm_resource_group.paas_resource_group.name
}

resource "azurerm_kubernetes_cluster" "sample-app-AKS" {
    name                      = var.aks-cluster-name
    location                  = azurerm_resource_group.paas_resource_group.location
    resource_group_name       = azurerm_resource_group.paas_resource_group.name
    sku_tier                  = var.aks-sku
    dns_prefix                = var.dns_aks_prefix
    kubernetes_version        = var.kube_version
    automatic_channel_upgrade = var.aks_auto_upgrade
    private_cluster_enabled   = var.aks_api_private
    node_resource_group       = "${var.aks-cluster-name}-nodepool-rc"
    oidc_issuer_enabled       = false
        
    default_node_pool {
        name                    = "akspool"
        #Le nombre initial de Node (doit être entre min_count et max_count)
        node_count              = 2
        vm_size                 = "Standard_B2s"
        os_disk_size_gb         = 128
        os_disk_type            = "Managed"
        kubelet_disk_type       = "OS"
        max_pods                = 20 
        type                    = "VirtualMachineScaleSets"
        #Nombre de Node Max
        max_count               = 10 
        #Nombre de Node Min
        min_count               = 2
        enable_auto_scaling     = true
        orchestrator_version    = var.kube_version
        os_sku                  = "Ubuntu"
        enable_node_public_ip   = false
    }

    network_profile {
        network_plugin    = "kubenet"
        network_policy    = "calico"
        load_balancer_sku = "standard"
    }

    identity {
        type = "UserAssigned"
        identity_ids = [
            azurerm_user_assigned_identity.AKS_managed_identity.id
        ]
    }

    lifecycle {
        ignore_changes = [default_node_pool[0].node_count]
    }

    tags = var.tags
}

## Give the permission to the AKS to pull image on the Container Registry on another Resource Group. 
resource "azurerm_role_assignment" "aks-cr" {
    principal_id         = azurerm_kubernetes_cluster.sample-app-AKS.kubelet_identity[0].object_id
    role_definition_name = "AcrPull"
    scope                = data.azurerm_container_registry.rc-data.id
}

## Give the permission to the AKS to manipulate the Public IP adresse (read, join it to the Ingress Controller Load Balancer IP)
data "azurerm_resource_group" "public_ip_rg" {
    name = var.rg_public_ip
}

resource "azurerm_role_assignment" "aks-manip-rg-public-ip" {
    scope                = data.azurerm_resource_group.public_ip_rg.id
    role_definition_name = "Network Contributor"
    principal_id         = azurerm_user_assigned_identity.AKS_managed_identity.principal_id
}