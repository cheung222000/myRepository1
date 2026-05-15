#https://github.com/Azure-Terraform/terraform-azurerm-virtual-network.git?ref=v8.1.0

module "subnet" {
  source   = "./subnet"
  for_each = local.subnets
}
