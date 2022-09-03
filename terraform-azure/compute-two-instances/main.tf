data "azurerm_resource_group" "main" {
    name = "ldbc-rg"
}

resource "azurerm_proximity_placement_group" "main" {
    name                  = "${var.name_prefix}-proximity-pg"
    location              = data.azurerm_resource_group.main.location
    resource_group_name   = data.azurerm_resource_group.main.name

    tags = {
        environment         = var.cost_allocation_tag
    }
}

resource "azurerm_linux_virtual_machine" "driver" {
    name                = "${var.name_prefix}-driver"
    resource_group_name = data.azurerm_resource_group.main.name
    location            = data.azurerm_resource_group.main.location
    size                = var.driver_compute_instance
    admin_username      = var.administrator_username

    proximity_placement_group_id = azurerm_proximity_placement_group.main.id

    network_interface_ids = [
        azurerm_network_interface.driver.id,
    ]

    admin_ssh_key {
        username   = var.administrator_username
        public_key = file(var.administrator_public_key_path)
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

    provisioner "local-exec" {
        command = <<EOT
            sleep 180;
            >ldbc-driver.ini;
            echo "[ldbc]" | tee -a ldbc-driver.ini;
            echo "${self.public_ip_address} ansible_user=${var.administrator_username} ansible_ssh_private_key_file=${var.administrator_public_key_path}" | tee -a ldbc-driver.ini;
            export ANSIBLE_HOST_KEY_CHECKING=False;
            ansible-playbook -u ${var.administrator_username} --private-key ${var.administrator_public_key_path} -i ldbc-driver.ini playbooks/main-driver.yml
            EOT
    }

    tags = {
        environment = var.cost_allocation_tag
    }
}


resource "azurerm_linux_virtual_machine" "sut" {
    name                = "${var.name_prefix}-sut"
    resource_group_name = data.azurerm_resource_group.main.name
    location            = data.azurerm_resource_group.main.location
    size                = var.sut_compute_instance
    admin_username      = var.administrator_username

    proximity_placement_group_id = azurerm_proximity_placement_group.main.id

    network_interface_ids = [
        azurerm_network_interface.sut.id,
    ]

    admin_ssh_key {
        username   = var.administrator_username
        public_key = file(var.administrator_public_key_path)
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

    provisioner "local-exec" {
        command = <<EOT
            sleep 180;
            >ldbc-sut.ini;
            echo "[ldbc]" | tee -a ldbc-sut.ini;
            echo "${self.public_ip_address} ansible_user=${var.administrator_username} ansible_ssh_private_key_file=${var.administrator_public_key_path}" | tee -a ldbc-sut.ini;
            export ANSIBLE_HOST_KEY_CHECKING=False;
            ansible-playbook -u ${var.administrator_username} --private-key ${var.administrator_public_key_path} -i ldbc-sut.ini playbooks/main-sut.yml
            EOT
    }

    tags = {
        environment = var.cost_allocation_tag
    }
}
