#https://github.com/Azure-Terraform/terraform-azurerm-resource-group?ref=v2.1.1

resource "random_integer" "suffix" {
  count = var.unique_name == "true" ? 1 : 0  #if count is existed, the random_integer.suffix is a list. Call this list need to add index[0] for the first list item

  min = 10000
  max = 99999
}
