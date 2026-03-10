resource "azurerm_resource_group" "myAzureResourceGroup2" {
  name     = "shared-expressroute-prod-uksouth-dataservices-nonprod"
  location = var.location
}

resource "azurerm_local_network_gateway" "myAzureLocalNetworkGateway" {
  name                = "145.43.244.136-dataservices-nonprod-uksouth-local-network-gateway"
  resource_group_name = azurerm_resource_group.myAzureResourceGroup2.name
  location            = azurerm_resource_group.myAzureResourceGroup2.location
  gateway_address     = "145.43.244.136"
  address_space       = ["10.0.0.0/16"]
}
