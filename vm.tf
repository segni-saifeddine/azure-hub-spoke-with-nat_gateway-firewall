resource "random_password" "vm" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
  # Use a keeper to ensure the password remains the same as long as this value doesn't change
  keepers = {
    constant = "fixed-value"
  }
}

resource "azurerm_network_interface" "vm" {
  name                = "nic-vm-spoke"
  location            = azurerm_resource_group.spoke.location
  resource_group_name = azurerm_resource_group.spoke.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vm_spoke.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-spoke"
  resource_group_name = azurerm_resource_group.spoke.name
  location            = azurerm_resource_group.spoke.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.vm.id,
  ]

  admin_password = random_password.vm.result
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
source_image_reference {
    publisher = "Debian"
    offer     = "debian-11"
    sku       = "11"
    version   = "latest"
  }
}