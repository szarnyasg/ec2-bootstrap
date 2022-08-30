resource "azurerm_resource_group" "main" {
    name     = "${var.name_prefix}-rg"
    location = var.azure_region

    tags = {
        environment         = var.cost_allocation_tag
    }
}

resource "azurerm_proximity_placement_group" "main" {
    name                  = "${var.name_prefix}-proximity-pg"
    location              = azurerm_resource_group.main.name
    resource_group_name   = azurerm_resource_group.main.location

    tags = {
        environment         = var.cost_allocation_tag
    }
}


resource "azurerm_linux_virtual_machine" "driver" {
    name                = "${var.name_prefix}-driver"
    resource_group_name = azurerm_resource_group.ldbc.name
    location            = azurerm_resource_group.ldbc.location
    size                = var.driver_compute_instance
    admin_username      = var.administrator_username

    proximity_placement_group_id = azurerm_proximity_placement_group.ldbc.id

    network_interface_ids = [
        azurerm_network_interface.driver.id,
    ]

    admin_ssh_key {
        username   = var.administrator_username
        public_key = file(var.administrator_public_key)
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = var.linux_publisher
        offer     = var.linux_offer
        sku       = var.linux_sku
        version   = var.linux_version
    }

    tags = {
        environment = var.cost_allocation_tag
    }

}


resource "azurerm_linux_virtual_machine" "sut" {
    name                = "${var.name_prefix}-sut"
    resource_group_name = azurerm_resource_group.main.name
    location            = azurerm_resource_group.main.location
    size                = var.sut_compute_instance
    admin_username      = var.administrator_username

    proximity_placement_group_id = azurerm_proximity_placement_group.ldbc.id

    network_interface_ids = [
        azurerm_network_interface.sut.id,
    ]

    admin_ssh_key {
        username   = var.administrator_username
        public_key = file(var.administrator_public_key)
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = var.linux_publisher
        offer     = var.linux_offer
        sku       = var.linux_sku
        version   = var.linux_version
    }

    tags = {
        environment = var.cost_allocation_tag
    }
}

