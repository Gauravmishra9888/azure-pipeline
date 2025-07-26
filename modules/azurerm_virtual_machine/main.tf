resource "azurerm_linux_virtual_machine" "todovm" {
  name                = var.vm_name
  resource_group_name = var.vm_rg_name
  location            = var.vm_rg_location
  size                = "Standard_F2"
  admin_username      = var.vm_username
  admin_password      = var.vm_password
  disable_password_authentication = false
  network_interface_ids = var.vm_nic_id

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.vm_publisher
    offer     = var.vm_offer
    sku       = var.vm_sku
    version   = "latest"
  }
}



