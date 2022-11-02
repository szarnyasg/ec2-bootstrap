cost_allocation_tag = "LDBC"
name_prefix = "ldbc"
azure_region = "eastus"

driver_compute_instance = "Standard_E8d_v5"
sut_compute_instance = "Standard_E8d_v5"
# VM information
administrator_username = "ubuntu"
administrator_public_key_path = "/home/gladap/.ssh/id_azure_tf.pub"

linux_publisher = "Canonical"
linux_offer     = "0001-com-ubuntu-server-focal"
linux_sku       = "20_04-lts"
linux_version   = "latest"

sql_publisher = "MicrosoftSQLServer"
sql_offer     = "sql2019-ubuntu2004"
sql_sku       = "standard"
sql_version   = "15.0.220913"

mssql_connectivity_update_password = "MySecr3tP4ssword"
mssql_connectivity_update_username = "SA"
mssql_port = 1433
