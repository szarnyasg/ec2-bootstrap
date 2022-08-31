cost_allocation_tag = "LDBC"
name_prefix = "ldbc"
azure_region = "westus2"

driver_compute_instance = "Standard_D13_v2"
sut_compute_instance = "Standard_D13_v2"

# VM information
administrator_username = "ubuntu"
administrator_public_key_path = "~/.ssh/id_azure_tf.pub"

linux_publisher = "Canonical"
linux_offer = "UbuntuServer"
linux_sku = "20.04-LTS"
linux_version = "latest"

mssql_connectivity_update_password = "MySecr3tP4ssword"
mssql_connectivity_update_username = "SA"
mssql_port = 1433
