#https://github.com/Azure-Terraform/terraform-azurerm-virtual-network.git?ref=v8.1.0

resource "azurerm_virtual_network" "vnet" {
  name                = local.virtual_network_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  tags                = var.tags
  dns_servers         = var.dns_servers
}

module "subnet" {
  source   = "./subnet"
  for_each = local.subnets

  names                = var.names

  resource_group_name  = var.resource_group_name
  location             = var.location
  tags                 = var.tags

  naming_rules         = var.naming_rules
  enforce_subnet_names = local.enforce_subnet_names

  virtual_network_name = azurerm_virtual_network.vnet.name
/*  subnet_type          = each.key
  cidrs                = each.value.cidrs

  private_endpoint_network_policies             = each.value.private_endpoint_network_policies
  private_link_service_network_policies_enabled = each.value.private_link_service_network_policies_enabled
  default_outbound_access_enabled               = each.value.default_outbound_access_enabled

  service_endpoints = each.value.service_endpoints
  delegations       = each.value.delegations

  create_network_security_group = each.value.create_network_security_group
  security_group_prefix         = each.value.security_group_prefix
  configure_nsg_rules           = each.value.configure_nsg_rules
  allow_internet_outbound       = each.value.allow_internet_outbound
  allow_lb_inbound              = each.value.allow_lb_inbound
  allow_vnet_inbound            = each.value.allow_vnet_inbound
  allow_vnet_outbound           = each.value.allow_vnet_outbound
*/
}

/*
					  subnets = {
						"GatewaySubnet" = {
							cidrs                                         = [local.hub_cidrs[each.key].subnets[0]]
							private_endpoint_network_policies             = "true"
							private_link_service_network_policies_enabled = true
							service_endpoints                             = []
							delegations                                   = {}
							create_network_security_group                 = false
							security_group_prefix                         = null
							configure_nsg_rules                           = true
							allow_internet_outbound                       = false
							allow_lb_inbound                              = false
							allow_vnet_inbound                            = false
							allow_vnet_outbound                           = false
							route_table_association                       = null
						},
						"AzureFirewallSubnet" = {
							cidrs                                         = [local.hub_cidrs[each.key].subnets[1]]
							private_endpoint_network_policies             = "true"
							private_link_service_network_policies_enabled = true
							service_endpoints                             = []
							delegations                                   = {}
							create_network_security_group                 = false
							security_group_prefix                         = null
							configure_nsg_rules                           = true
							allow_internet_outbound                       = false
							allow_lb_inbound                              = false
							allow_vnet_inbound                            = false
							allow_vnet_outbound                           = false
							route_table_association                       = null
						},
					  }
*/
