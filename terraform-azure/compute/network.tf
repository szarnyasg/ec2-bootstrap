resource "azurerm_virtual_network" "main" {
    name                = "${var.name_prefix}-network"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name

    tags = {
        environment = var.cost_allocation_tag
    }
}

resource "azurerm_subnet" "main" {
    name                 = "${var.name_prefix}-subnet"
    resource_group_name  = azurerm_resource_group.main.name
    virtual_network_name = azurerm_virtual_network.main.name
    address_prefixes     = ["10.0.1.0/24"]

    tags = {
        environment = var.cost_allocation_tag
    }
}

resource "azurerm_network_interface" "driver" {
    name                = "${var.name_prefix}-driver-nic"
    location            = azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name

    ip_configuration {
        name                          = "${var.name_prefix}-driver-ip"
        subnet_id                     = azurerm_subnet.main.id
        private_ip_address_allocation = "Dynamic"
    }

    tags = {
        environment = var.cost_allocation_tag
    }
}

resource "azurerm_network_interface" "sut" {
    name                = "${var.name_prefix}-sut-nic"
    location            = azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name

    ip_configuration {
        name                          = "${var.name_prefix}-sut-ip"
        subnet_id                     = azurerm_subnet.main.id
        private_ip_address_allocation = "Dynamic"
    }

      tags = {
        environment = var.cost_allocation_tag
    }
}