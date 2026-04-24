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

module "resource_group" {
  source   = "./modules/resource_group"
  for_each = local.hubs

  unique_name = each.value.name                            #dataservices-nonprod
  location    = module.metadata[each.key].location
  names       = module.metadata[each.key].names            //module.metadata[dataservices-nonprod-uksouth].names
  tags        = module.metadata[each.key].tags

                                                      /*
                                                        names = merge( #creating object
                                                          { #mandatory values
                                                            business_unit     = var.business_unit      //iog
                                                            environment       = var.environment        //prod
                                                            location          = var.location           //uksouth
                                                            market            = var.market             //us
                                                            subscription_type = var.subscription_type  //production
                                                          }
                                                        )
                                                      */
}

/*output "current_subscription_id" {
  value = nonsensitive(data.azurerm_subscription.current.subscription_id)
  #sensitive = false
}*/

                                            /*
                                            "dataservices-nonprod-uksouth" = ***
                                              "client_ranges" = [
                                                "10.73.64.0/18",
                                              ]
                                              "firewall_sku" = "Premium"
                                              "hub_range" = "10.241.38.0/24"
                                              "name" = "dataservices-nonprod"
                                              "region" = "uksouth"
                                              "vpn" = ***
                                                "asn" = 64562
                                                "bgp_addresses" = [
                                                  "169.254.21.15",
                                                  "169.254.22.15",
                                                  "169.254.21.14",
                                                  "169.254.22.14",
                                                ]
                                                "gateway_traffic" = [
                                                  "145.43.244.136",
                                                  "145.43.244.168",
                                                ]
                                                "ranges" = [
                                                  "10.55.208.0/21",
                                                ]
                                                "sku" = "VpnGw2AZ"
                                            */

module "virtual_network" {
  source   = "./modules/virtual_network"
  for_each = local.hubs

  resource_group_name = module.resource_group[each.key].name
  location            = module.metadata[each.key].location
  names               = module.metadata[each.key].names
  tags                = module.metadata[each.key].tags
}
