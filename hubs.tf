module "metadata" {
  source   = "./modules/metadata"

  naming_rules = "my_naming_rule"

  market              = "us"
  project             = "Global Network Hub"
  environment         = "prod"
  product_name        = "expressroute"
  business_unit       = "iog"
  product_group       = "networks"
  subscription_id     = "subid"
  subscription_type   = "production"
  resource_group_type = "shared"
}
