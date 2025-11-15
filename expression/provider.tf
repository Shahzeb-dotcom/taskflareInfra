terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.33.0"
    }
  }
}

provider "azurerm" {
  features {

  }
  # Configuration options
  subscription_id = "e8f942cf-6360-46ff-b017-31ede6559daf"
}