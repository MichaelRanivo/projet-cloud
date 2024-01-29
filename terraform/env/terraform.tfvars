# default
resource_group_location                 = "northeurope"

#Infra Backend
backend_resource_group_name             = "tf-back-rg"
azure_cloud_location                    = "North Europe"
backend_storage_account_name            = "tfbackstorageaccount"
storage_account_tier                    = "Standard"
storage_account_replication_type        = "LRS"
storage_container_name                  = "tfbackendstoragecontainer"
storage_container_access_type           = "private"

#DB
resource_group_db_name                  = "sampleappdbresourcegroup"
database_name                           = "laravel"
database_server_name                    = "dbserver"
database_sku                            = "B_Standard_B1s"

# Container registry
resource_group_container_registry       = "cr-resource-group"
container_registry_name                 = "sampleappcr"

# IAAS
iaas_resource_group_name                = "iaas-rg"
iaas_vnet_name                          = "iaas-vnet"
iaas_subnet_name                        = "iaas-subnet"

## IAAS IP LB
rg_iaas_address_ip_name                 = "dns"
iaas_address_ip_name                    = "lb-ip-iaas"
iaas_lb_name                            = "iaas-lb"
iaas_lb_Public_IP_Address_name          = "iaas-lb-front-IP"
iaas_lb_backend_pool_name               = "lb-backend-pool"
iaas_lb_backend_pool_master             = "addMasterNodeBackendPool"
iaas_lb_backend_pool_worker             = "addWorkerNode"
iaas_lb_probe_name                      = "healtProbeLB"
iaas_lb_rule_80_name                    = "inboundrule80"
iaas_lb_rule_443_name                   = "inboundrule443"
iaas_lb_nat_rule_name_ssh               = "inboundNatRulesSsh"
iaas_lb_nat_rule_name_Kube              = "inboundNatRulesApiKubeEndpoint"

######### NODE MASTER ##############

## SSH Config key vars node master
node_ssh_public_key_type                = "Microsoft.Compute/sshPublicKeys@2023-03-01"
node_master_ssh_public_key_name         = "VMNodeMasterPublicKey"
node_worker_ssh_public_key_name         = "VMNodeWorkerPublicKey"

## NODE MASTER
vm_node_master_name                     = "master"
vm_node_master_size                     = "Standard_D2as_v4"
vm_node_master_os_disk_name             = "NodeMasterVMOsDisk"
vm_node_master_image_pub                = "canonical"
vm_node_master_image_offer              = "0001-com-ubuntu-server-jammy"
vm_node_master_image_sku                = "22_04-lts-gen2"
vm_node_master_image_version            = "latest"

## Node Master username
node_master_username                    = "master_user"

## Public IP for the node master
node_master_public_ip_name              = "NodeMasterPublicIP"

## Node Master Network Security Group and rule
node_master_network_sg_name             = "nodeMasterSg"
net_int_ip_config_name                  = "nodeMasterNetIntConfigIp"

## Network interface 
net_int_node_master_name                = "nodemasternetinte"

######### NODE WORKER ##############

nomber_of_vm_worker                     = 2

## Network Interface Node Worker
net_int_node_worker_name                = "NetIntNodeWorker"
net_int_ip_config_worker_name           = "NetIntIpCongNodeWorker"

## VM Node Worker
vm_node_worker_name                     = "worker"
vm_node_worker_size                     = "Standard_B2s"
vm_node_worker_os_disk_name             = "NodeWorkerVMOsDisk"
vm_node_worker_image_pub                = "canonical"
vm_node_worker_image_offer              = "0001-com-ubuntu-server-jammy"
vm_node_worker_image_sku                = "22_04-lts-gen2"
vm_node_worker_image_version            = "latest"

## Node Worker username
node_worker_username                    = "worker_user"

## Node Worker Network Security Group and rule
node_worker_network_sg_name             = "nodeWorkerSg"

# PAAS
paas_resource_group_name                = "paas-rg"
aks-cluster-name                        = "sample-app-AKS"
dns_aks_prefix                          = "sampleappaks"
kube_version                            = "1.27.3"
aks-sku                                 = "Free"
aks_auto_upgrade                        = "stable"
aks_api_private                         = false

## Public IP for LaodBalancer
lb_public_ip_name                       = "lb-ip"
rg_public_ip                            = "dns"

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