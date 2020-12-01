terraform {
  required_version = ">= 0.12"
  required_providers {
    azurerm = {
      version = "~> 2.38.0"
    }
    kubernetes = {
      version = "~> 1.13.0"
    }
  }
}
