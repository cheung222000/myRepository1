#https://github.com/Azure-Terraform/terraform-azurerm-virtual-network.git?ref=v8.1.0

module "subnet" {
  source   = "./subnet"
  for_each = local.subnets
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
