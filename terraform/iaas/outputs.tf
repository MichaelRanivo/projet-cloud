output "node_master_private_ip_address" {
  value = azurerm_linux_virtual_machine.node_master_vm.private_ip_address
}

resource "local_file" "node_master_private_key" {
  content  = jsondecode(azapi_resource_action.node_master_ssh_public_key_gen.output).privateKey
  filename = "node_master_private_key.pem"
}

output "node_worker_0_pribate_ip_address" {
  value = azurerm_linux_virtual_machine.node_worker_vm[0].private_ip_address
}

output "node_worker_1_pribate_ip_address" {
  value = azurerm_linux_virtual_machine.node_worker_vm[1].private_ip_address
}

resource "local_file" "node_worker_0_private_key" {
  content  = jsondecode(azapi_resource_action.node_worker_ssh_public_key_gen[0].output).privateKey
  filename = "node_worker_0_private_key.pem"
}

resource "local_file" "node_worker_1_private_key" {
  content  = jsondecode(azapi_resource_action.node_worker_ssh_public_key_gen[1].output).privateKey
  filename = "node_worker_1_private_key.pem"
}