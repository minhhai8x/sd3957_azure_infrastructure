resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                = "${azurerm_resource_group.aks_rg.name}-vm"
  resource_group_name = azurerm_resource_group.aks_rg.name
  location            = azurerm_resource_group.aks_rg.location
  size                = "Standard_D2pls_v5"
  admin_username      = "${var.vm_admin_username}"
  network_interface_ids = [
    azurerm_network_interface.aks_nic.id,
  ]

  admin_ssh_key {
    username   = "${var.vm_admin_username}"
    public_key = tls_private_key.ssh_key.public_key_openssh
  }

  os_disk {
    name                 = "${azurerm_resource_group.aks_rg.name}-OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
