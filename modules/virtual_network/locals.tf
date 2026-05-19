locals {
  virtual_network_name = (var.virtual_network_name != null && var.virtual_network_name != "" ? var.virtual_network_name : (var.use_product_name ? "${var.names.product_name}-${var.names.subscription_type}-${var.names.location}-vnet" : "${var.names.product_group}-${var.names.subscription_type}-${var.names.location}-vnet"))
  subnets = zipmap(keys(var.subnets), [for subnet in values(var.subnets) : merge(var.subnet_defaults, subnet)])

/*
  "GatewaySubnet" = {
    cidrs                                         	= [local.hub_cidrs[each.key].subnets[0]]
    create_network_security_group                 	= false
    private_endpoint_network_policies_enabled     	= true
    private_link_service_network_policies_enabled 	= true
  }
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  default = {
    cidrs                                         = []
    private_endpoint_network_policies             = "Disabled"
    private_link_service_network_policies_enabled = true
    service_endpoints                             = []
    delegations                                   = {}
    create_network_security_group                 = true
    security_group_prefix                         = null
    configure_nsg_rules                           = true
    allow_internet_outbound                       = false
    allow_lb_inbound                              = false
    allow_vnet_inbound                            = false
    allow_vnet_outbound                           = false
    route_table_association                       = null
  }
  VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV
    "GatewaySubnet" = {
    cidrs                                         = [local.hub_cidrs[each.key].subnets[0]]
    private_endpoint_network_policies             = "Disabled"
    private_link_service_network_policies_enabled = true
    service_endpoints                             = []
    delegations                                   = {}
    create_network_security_group                 = true
    create_network_security_group                 = false
    configure_nsg_rules                           = true
    allow_internet_outbound                       = false
    allow_lb_inbound                              = false
    allow_vnet_inbound                            = false
    allow_vnet_outbound                           = false
    route_table_association                       = null
    }
*/

  enforce_subnet_names = (var.naming_rules == "" ? false : var.enforce_subnet_names)
  #enforce_subnet_names = false (if var.naming_rules == "")
  #OR enforce_subnet_names = var.enforce_subnet_names (var.naming_rules != "")

}
