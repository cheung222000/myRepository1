resource "azurerm_resource_group" "example" {
  name     = "localNetworkGWTest"
  location = "West Europe"
}

resource "azurerm_local_network_gateway" "home" {
  name                = "backHome"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  gateway_address     = "12.13.14.15"
  address_space       = [""]
}
