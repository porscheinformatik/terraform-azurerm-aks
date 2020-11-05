# Terraform Module for AKS

An opinionated module for creating AKS clusters with Porsche Informatik defaults.

## Usage

```hcl
resource "azurerm_resource_group" "main" {
  name     = "poi-mygroup-dev-rg"
  location = "West Europe"
}

module "aks" {
  source                    = "porscheinformatik/aks/azurerm"
  resource_group_name       = azurerm_resource_group.main.name
  resource_group_location   = azurerm_resource_group.main.location
  prefix                    = "poi-mygroup-dev"
  namespaces = {
    "poi-mygroup" = {
      owner = "emailof.admin@porscheinformatik.com",
    }
  }
}
```
