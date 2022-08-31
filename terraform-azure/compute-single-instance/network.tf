resource "azurerm_virtual_network" "main" {
    name                = "${var.name_prefix}-network"
    address_space       = ["10.0.0.0/16"]
    location            = data.azurerm_resource_group.main.location
    resource_group_name = data.azurerm_resource_group.main.name

    tags = {
        environment = var.cost_allocation_tag
    }
}

resource "azurerm_subnet" "main" {
    name                 = "${var.name_prefix}-subnet"
    resource_group_name  = data.azurerm_resource_group.main.name
    virtual_network_name = azurerm_virtual_network.main.name
    address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "main-sg-ssh" {
  name                = "${var.name_prefix}-sg-ssh"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "driver" {
    network_interface_id      = azurerm_network_interface.driver.id
    network_security_group_id = azurerm_network_security_group.main-sg-ssh.id
}

resource "azurerm_public_ip" "driver" {
  name                = "${var.name_prefix}-driver-public-ip"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "driver" {
    name                = "${var.name_prefix}-driver-nic"
    location            = data.azurerm_resource_group.main.location
    resource_group_name = data.azurerm_resource_group.main.name

    ip_configuration {
        name                          = "${var.name_prefix}-driver-ip"
        subnet_id                     = azurerm_subnet.main.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.driver.id
    }

    tags = {
        environment = var.cost_allocation_tag
    }
}
