terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 4.54.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraform-rg"
    storage_account_name = "tfstate889243219119"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
