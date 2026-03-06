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
