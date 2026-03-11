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

resource "azurerm_public_ip" "myAzurePublicIP" {
  name                = "145.43.244.136-dataservices-nonprod-uksouth-vpngateway-ip"
  resource_group_name = azurerm_resource_group.myAzureResourceGroup2.name
  location            = azurerm_resource_group.myAzureResourceGroup2.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}

resource "azurerm_virtual_network_gateway" "myAzureVirtualNetworkGateway" {
  name                = "dataservices-nonprod-uksouth-virtual-network-gateway"
  location            = azurerm_resource_group.myAzureResourceGroup2.location
  resource_group_name = azurerm_resource_group.myAzureResourceGroup2.name
  #tags                = module.metadata[each.key].tags
  type                = "Vpn"
  vpn_type            = "RouteBased"

  active_active = true
  enable_bgp    = true

  generation = "Generation2"

  sku = "VpnGw2AZ"

  /*bgp_settings {
    asn = "64562"
    peering_addresses {
      ip_configuration_name = "gateway-config-0"
      apipa_addresses       = "169.254.21.15"
    }
    peering_addresses {
      ip_configuration_name = "gateway-config-1"
      apipa_addresses       = "169.254.22.15"
    }
  }

  ip_configuration {
    name                          = "gateway-config-0"
    public_ip_address_id          = "4.250.250.128"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = module.virtual_network[each.key].subnet["GatewaySubnet"].id
  }
  ip_configuration {
    name                          = "gateway-config-1"
    public_ip_address_id          = "145.133.68.93"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = module.virtual_network[each.key].subnet["GatewaySubnet"].id
  }
  */
}
