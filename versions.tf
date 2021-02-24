terraform {
  required_version = ">= 0.12"
  required_providers {
    azurerm = {
      version = "~> 2.48.0"
    }
    kubernetes = {
      version = "~> 2.0.0"
    }
  }
}
