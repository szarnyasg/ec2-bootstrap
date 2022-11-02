# This resource uses a virtual machine resource
resource "azurerm_mssql_virtual_machine" "sut" {
    virtual_machine_id               = azurerm_virtual_machine.sut.id
    sql_license_type                 = var.mssql_license_type
    sql_connectivity_port            = var.mssql_port
    sql_connectivity_type            = var.mssql_connectivity_type
    sql_connectivity_update_password = var.mssql_connectivity_update_password
    sql_connectivity_update_username = var.mssql_connectivity_update_username

    tags = {
        environment = var.cost_allocation_tag
    }
}
