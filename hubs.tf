module "metadata" {
  source   = "github.com/Azure-Terraform/terraform-azurerm-metadata.git?ref=v1.5.3"
  for_each = local.hubs

  #naming_rules = module.naming.yaml

  market              = "us"
  project             = "Global Network Hub"
  #location            = each.value.region
  environment         = "prod"
  product_name        = "expressroute"
  business_unit       = "iog"
  product_group       = "networks"
  #subscription_id     = data.azurerm_subscription.current.subscription_id
  subscription_type   = "production"
  resource_group_type = "shared"
}
