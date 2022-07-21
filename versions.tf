terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      version = ">= 3.0.0"
    }
    kubernetes = {
      version = ">= 2.0.0"
    }
  }
}
