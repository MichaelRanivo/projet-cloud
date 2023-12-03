output "public_ip_address" {
  value = azurerm_linux_virtual_machine.node_master_vm.public_ip_address
}

output "key_data" {
  value = jsondecode(azapi_resource_action.ssh_public_key_gen.output).privateKey
}