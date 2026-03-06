terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 4.54.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
/*
terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-rg"
    storage_account_name = "tfstate889243219119"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
*/
/*
terraform {
  backend "azurerm" {
    resource_group_name  = "tf-stage-azure-open-ai"
    storage_account_name = "terraformstateopen2024ai"
    container_name       = "terraformopenai2024"
    key                  = "terraform.tfstate"
  }
}*/
/*
variable "prefix" {
  default = "tfvmex"
}

resource "azurerm_resource_group" "myAzureResourceGroup1" {
  name     = "${var.prefix}-resources"
  location = var.location
}

resource "azurerm_virtual_network" "myAzureVirtualNetwork1" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.myAzureResourceGroup1.location
  resource_group_name = azurerm_resource_group.myAzureResourceGroup1.name
}

resource "azurerm_subnet" "myAzureSubnet1" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.myAzureResourceGroup1.name
  virtual_network_name = azurerm_virtual_network.myAzureVirtualNetwork1.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "myAzureNetworkInterface1" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.myAzureResourceGroup1.location
  resource_group_name = azurerm_resource_group.myAzureResourceGroup1.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.myAzureSubnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}
*/
