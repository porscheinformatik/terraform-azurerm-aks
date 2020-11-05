provider "azurerm" {
  features {}
}

resource "random_string" "prefix" {
  length = 6
  special = false
  upper = false
  number = false
}

resource "azurerm_resource_group" "main" {
  name     = "poi-${random_string.prefix.result}-rg"
  location = "westeurope"
}

module "aks" {
  source                    = "../"
  resource_group_name       = azurerm_resource_group.main.name
  resource_group_location   = azurerm_resource_group.main.location
  prefix                    = "poi-${random_string.prefix.result}"
  namespaces = {
    "demo" = {
      owner = "myaccount@porscheinformatik.com",
    }
  }
}
