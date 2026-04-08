#github.com/Azure-Terraform/terraform-azurerm-metadata.git?ref=v1.5.3

locals {
  location = local.naming_rules.azureRegion.allowed_values[var.location]
}
