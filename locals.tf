locals {
  hub_data = yamldecode(file("./data/hubs.yaml"))
}
output "hub_data_debug" {
  value = local.hub_data
}
output "hub_data_debug2" {
  value = jsonencode(local.hub_data)
}
output "hub_data_debug3" {
  value = local.hub_data["uksouth"]
}
output "formatted_hubs_debug" {
  value = local.formatted_hubs
}
