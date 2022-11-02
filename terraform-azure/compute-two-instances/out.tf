output "driver_public_ip" {
    value = azurerm_linux_virtual_machine.driver.public_ip_address
}

output "driver_private_ip" {
    value = azurerm_linux_virtual_machine.driver.private_ip_address
}

output "sut_public_ip" {
    value = azurerm_public_ip.sut.ip_address
}

output "sut_private_ip" {
    value = azurerm_network_interface.sut.private_ip_address
}
