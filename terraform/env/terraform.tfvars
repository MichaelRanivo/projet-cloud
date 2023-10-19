#Virtual network vars
vnet_name                   = "ImageVMVnet"
vnet_ip_addr                = ["10.0.0.0/16"]
resource_group_location     = "northeurope"
resource_group_name         = "t-clo-907-lyo-3"

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