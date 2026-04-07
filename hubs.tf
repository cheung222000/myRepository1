module "metadata" {
  source   = "./modules/metadata"
  for_each = local.hubs

  naming_rules = "my_naming_rule"

  market              = "us"
  project             = "Global Network Hub"
  location            = "usus"
  environment         = "prod"
  product_name        = "expressroute"
  business_unit       = "iog"
  product_group       = "networks"
  subscription_id     = data.azurerm_subscription.current.subscription_id
  subscription_type   = "production"
  resource_group_type = "shared"
}


output "current_subscription_id" {
  value = nonsensitive(data.azurerm_subscription.current.subscription_id)
  sensitive = false
}
