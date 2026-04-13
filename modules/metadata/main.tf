#github.com/Azure-Terraform/terraform-azurerm-metadata.git?ref=v1.5.3

locals {

  location = local.naming_rules.azureRegion.allowed_values[var.location]

  names = merge(
    { #mandatory values
      business_unit     = var.business_unit
      environment       = var.environment
      location          = var.location
      market            = var.market
      subscription_type = var.subscription_type
    }, #optional values
    var.on_prem != "" ? { on_prem = var.on_prem } : {},
    #var.product_group != "" ? { product_group = var.product_group } : {},
    #var.product_name != "" ? { product_name = var.product_name } : {},
    #var.resource_group_type != "" ? { resource_group_type = var.resource_group_type } : {},
    #var.service_name != "" ? { service_name = var.service_name } : {},
    #var.subnet_type != "" ? { subnet_type = var.subnet_type } : {},
    #var.virtual_network_gateway_type != "" ? { virtual_network_gateway_type = var.virtual_network_gateway_type } : {},
  )
/*
  names = merge(
    {
      business_unit     = var.business_unit
      environment       = var.environment
      location          = var.location
      market            = var.market
      subscription_type = var.subscription_type
    },
    var.on_prem != "" ? { on_prem = var.on_prem } : {},
    var.product_group != "" ? { product_group = var.product_group } : {},
    var.product_name != "" ? { product_name = var.product_name } : {},
    var.resource_group_type != "" ? { resource_group_type = var.resource_group_type } : {},
    var.service_name != "" ? { service_name = var.service_name } : {},
    var.subnet_type != "" ? { subnet_type = var.subnet_type } : {},
    var.virtual_network_gateway_type != "" ? { virtual_network_gateway_type = var.virtual_network_gateway_type } : {},
  )
*/
  
}
