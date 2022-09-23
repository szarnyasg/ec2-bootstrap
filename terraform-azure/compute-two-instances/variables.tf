variable "cost_allocation_tag" {
    type = string
    description = "Tag to use to identify the deployment"
}

variable "name_prefix" {
    type = string
    description = "Name prefix to use for the resources"
}

variable "azure_region" {
    type = string
    description = "The Azure region to deploy to"
}

variable "driver_compute_instance" {
    type = string
    description = "The Azure Compute instance to use for the LDBC SNB-I Driver"
}

variable "sut_compute_instance" {
    type = string
    description = "The Azure Compute instance to use for the SUT"
}

variable "administrator_username" {
    type = string
    description = "The Administrator username for the instances"
}

variable "administrator_public_key_path" {
    type = string
    description = "The Administrator public key path to file for the instances"
}

# OS info
variable "linux_publisher" {
    type = string
    description = "Publisher of the Linux image, e.g. Canonical"
}

variable "linux_offer" {
    type = string
    description = "Offer of the Linux image, e.g. UbuntuServer"
}

variable "linux_sku" {
    type = string
    description = "SKU of the Linux image, e.g. 20.04-LTS"
}

variable "linux_version" {
    type = string
    description = "Version of the Linux image, e.g. latest"
}

# SQL info
variable "sql_publisher" {
    type = string
    description = "Publisher of the SQL image, e.g. MicrosoftSQLServer"
}

variable "sql_offer" {
    type = string
    description = "Offer of the SQL image, e.g. sql2019-ubuntu2004"
}

variable "sql_sku" {
    type = string
    description = "SKU of the SQL image, e.g. standard"
}

variable "sql_version" {
    type = string
    description = "Version of the SQL image, e.g. 15.0.220913"
}

# Azure SQL Server VM info

variable "mssql_port" {
    type = number
    description = "Port to use for SQL Server, e.g. 1433"
}

variable "mssql_connectivity_type" {
    type = string
    description = "SQL Server connectivity type, e.g. LOCAL|PRIVATE|PUBLIC"
    default = "PRIVATE"
}

variable "mssql_connectivity_update_password" {
    type = string
    description = "SQL Server password"
}

variable "mssql_connectivity_update_username" {
    type = string
    description = "SQL Server username"
}

variable "mssql_license_type" {
    type = string
    description = "SQL Server license type. Default Pay-as-you-go (PAYG)"
    default = "PAYG"
}

# SQL Server Storage options:
# https://docs.microsoft.com/en-us/azure/azure-sql/virtual-machines/windows/storage-configuration?view=azuresql-vm&tabs=windows2016
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_virtual_machine#storage_configuration
# SQL Server PaaS:
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server
