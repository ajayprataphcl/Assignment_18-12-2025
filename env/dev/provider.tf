terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.55.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "shyam"
    storage_account_name = "projectdev123"
    container_name       = "etihad"
    key                  = "dev.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "d4de6480-0ae2-4f72-b738-fd3b3b705bde"
}
