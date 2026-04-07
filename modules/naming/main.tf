#https://github.com/risk-shared/terraform-azurerm-naming

output "yaml" {
  value = yamlencode(jsondecode(file("${path.module}/custom.json")))
}
