terraform {
  required_version = ">= 0.12"
  required_providers {
    azurerm = {
      version = "~> 2.45.0"
    }
    kubernetes = {
      version = "~> 1.13.0"
    }
  }
}
