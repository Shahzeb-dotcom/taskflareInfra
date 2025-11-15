terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.33.0"
    }
  }
}

provider "azurerm" {
  features {}
  # Configuration options
  subscription_id = "3be29ba2-b31c-4fbd-a7bb-c51bf50ef740"
}