resource "azurerm_resource_group" "ldbc" {
  name     = "ldbc-azure-rg"
  location = "West Europe"
}

resource "azurerm_proximity_placement_group" "ldbc" {
  name                = "ldbc-azure-proximity-pg"
  location            = azurerm_resource_group.ldbc.location
  resource_group_name = azurerm_resource_group.ldbc.name

  tags = {
    environment = "LDBC"
  }
}


resource "azurerm_linux_virtual_machine" "driver" {
    name                = "ldbc-driver"
    resource_group_name = azurerm_resource_group.ldbc.name
    location            = azurerm_resource_group.ldbc.location
    size                = "Standard_F2"
    admin_username      = "adminuser"

    proximity_placement_group_id = azurerm_proximity_placement_group.ldbc.id

  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "20.04-LTS"
    version   = "latest"
  }
}


resource "azurerm_linux_virtual_machine" "sut" {
    name                = "ldbc-sut"
    resource_group_name = azurerm_resource_group.ldbc.name
    location            = azurerm_resource_group.ldbc.location
    size                = "Standard_F2"
    admin_username      = "adminuser"

    proximity_placement_group_id = azurerm_proximity_placement_group.ldbc.id

  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "20.04-LTS"
    version   = "latest"
  }
}