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

#Virtual network vars
vnet_name                   = "ImageVMVnet"
vnet_ip_addr                = ["10.0.0.0/16"]
resource_group_name         = "t-clo-901-lyo-3"

#subnet vars
subnet_name                 = "ImageVMSubnet"
subnet_ip_addr              = ["10.0.1.0/24"]

#Public IPs vars
public_ip_name              = "ImageVMPublicIP"

#Network Security Group and Rules vars
network_sg_r_name           = "ImageVMNetSG_R"

#Network interface vars
net_interface_name          = "ImageVMNetInt"
net_inter_ip_config_name    = "ImageVMNetIntIPConfig"

#Virtual Machine vars
vm_name                     = "VmForImage"
vm_size                     = "Standard_B1s"
vm_os_disk_name             = "ImageVMOsDisk"
vm_image_pub                = "debian"
vm_image_offer              = "debian-11"
vm_image_sku                = "11"
vm_image_version            = "latest"

#SSH Config key vars
ssh_publick_key_type        = "Microsoft.Compute/sshPublicKeys@2023-03-01"
ssh_public_key_name         = "ImageVMPublicKey"

username                    = "azureadmin"

# PAAS
paas_resource_group_name        = "paas-rg"
assigned_identity_name          = "tfMyID"
data_container_registry_name    = "sampleappcrzrmod"
registry_role_definition_name   = "AcrPull"
app_service_plan_name           = "web-app-plan-sampleApp"
web_app_name                    = "sampleApp-web-app"
sample_app_port                 = 80
sample_app_docker_image_name    = "sample-app"

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