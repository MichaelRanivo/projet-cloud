# default
resource_group_location     = "northeurope"

#Infra Backend
backend_resource_group_name         = "tf-back-rg"
azure_cloud_location                = "North Europe"
backend_storage_account_name        = "tfbackstorageaccount"
storage_account_tier                = "Standard"
storage_account_replication_type    = "LRS"
storage_container_name              = "tfbackendstoragecontainer"
storage_container_access_type       = "private"

#DB
resource_group_db_name  = "sampleappdbresourcegroup"
database_name           = "laravel"
database_server_name    = "dbserver"
database_sku            = "B_Standard_B1s"

# Container registry
resource_group_container_registry = "cr-resource-group"
container_registry_name           = "sampleappcr"

# IAAS
iaas_resource_group_name    = "iaas-rg"
iaas_vnet_name              = "iaas-vnet"
iaad_subnet_name            = "iaas-subnet"

######### NODE MASTER ##############

## NODE MASTER
vm_node_master_name                     = "NodeMaster"
vm_node_master_size                     = "Standard_B1s"
vm_node_master_os_disk_name             = "NodeMasterVMOsDisk"
vm_node_master_image_pub                = "debian"
vm_node_master_image_offer              = "debian-12"
vm_node_master_image_sku                = "12-gen2"
vm_node_master_image_version            = "latest"

## SSH Config key vars node master
node_master_ssh_public_key_type         = "Microsoft.Compute/sshPublicKeys@2023-03-01"
node_master_ssh_public_key_name         = "VMNodeMasterPublicKey"
node_master_username                    = "k8smaster"

## Public IP for the node master
node_master_public_ip_name              = "NodeMasterPublicIP"

## Node Master Network Security Group and rule
node_master_network_sg_name             = "nodeMasterSg"
net_int_ip_config_name                  = "nodeMasterNetIntConfigIp"

## Network interface 
net_int_node_master_name                = "nodemasternetinte"

######### NODE WORKER ##############

## SSH PUBLIC KEY
node_master_ssh_public_key_name
node_master_ssh_public_key_type

## Network Interface Node Worker
net_int_node_worker_name                = "NetIntNodeWorker"
net_int_ip_config_worker_name           = "NetIntIpCongNodeWorker"

## VM Node Worker
vm_node_master_name
vm_node_master_size
vm_node_master_os_disk_name
vm_node_master_image_pub
vm_node_master_image_offer
vm_node_master_image_sku
vm_node_master_image_version
vm_noe_master_computer_name
node_master_username



# PAAS
paas_resource_group_name        = "paas-rg"
aks-cluster-name                = "sample-app-AKS"
dns_aks_prefix                  = "sampleappaks"
kube_version                    = "1.27.3"
aks-sku                         = "Free"
aks_auto_upgrade                = "stable"
aks_api_private                 = false

#Tags for all resources
tags = {
    Author          = "michael.ranivo@epitech.eu"
    Project         = "TerraCloud"
    Country         = "FR"
    Environment     = "POC"
    ApplicationID   = "Sample-App"
    Version         = "1"
    BackupPolicy    = "No-Backup"
}