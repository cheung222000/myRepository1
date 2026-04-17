#https://github.com/Azure-Terraform/terraform-azurerm-resource-group?ref=v2.1.1

resource "random_integer" "suffix" {
  count = var.unique_name == "true" ? 1 : 0

  min = 10000
  max = 99999
}
