
resource "azurerm_resource_group" "main" {
    name     = "${var.name_prefix}-rg"
    location = var.azure_region

    tags = {
        environment         = var.cost_allocation_tag
    }
}

resource "azurerm_storage_account" "main" {
    name                     = "ldbcscalablegraphsa"
    resource_group_name      = azurerm_resource_group.main.name
    location                 = azurerm_resource_group.main.location
    account_tier             = "Standard"
    account_replication_type = "LRS"

    tags = {
        environment = "LDBC"
    }
}

resource "azurerm_storage_container" "main" {
  name                  = "ldbc-data"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}
