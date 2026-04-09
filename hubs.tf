module "metadata" {
  source   = "./modules/metadata"
  for_each = local.hubs

  naming_rules = module.naming.yaml

  market              = "us"
  project             = "Global Network Hub"
  location            = each.value.region
  environment         = "prod"
  product_name        = "expressroute"
  business_unit       = "iog"
  product_group       = "networks"
  subscription_id     = data.azurerm_subscription.current.subscription_id
  subscription_type   = "production"
  resource_group_type = "shared"
}

#module "resource_group" {
  #source   = "github.com/Azure-Terraform/terraform-azurerm-resource-group.git?ref=v2.1.1"
  #for_each = local.hubs

  #unique_name = each.value.name
  #location    = module.metadata[each.key].location
  #names       = module.metadata[each.key].names
  #tags        = module.metadata[each.key].tags
#}

/*output "current_subscription_id" {
  value = nonsensitive(data.azurerm_subscription.current.subscription_id)
  #sensitive = false
}*/
